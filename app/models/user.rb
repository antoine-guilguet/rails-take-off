class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true;
  validates :last_name, presence: true;
  validates :email, presence: true

  has_many :trips, through: :trip_participants

  after_create :send_welcome_email

  acts_as_voter

  def render_initials
    !self.first_name.nil? ? self.first_name.first + self.last_name.first : ""
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

end
