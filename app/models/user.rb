class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  validates :first_name, presence: true;
  validates :last_name, presence: true;
  validates :email, presence: true

  has_many :trips, through: :trip_participants
  has_many :trip_participants
  has_many :my_trips, class_name: "Trip"

  after_create :send_welcome_email

  acts_as_voter

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def render_initials
    !self.first_name.nil? ? self.first_name.first + self.last_name.first : ""
  end

  def get_user_full_name
    if self.first_name
      self.first_name + " " + self.last_name
    else
      self.email
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

end
