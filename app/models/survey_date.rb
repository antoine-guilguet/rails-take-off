class SurveyDate < ActiveRecord::Base
  belongs_to :survey

  acts_as_votable

  def voted_by?(user)
    user.voted_for? self
  end

  def get_list_voters
    self.votes_for.up.by_type(User).voters.map{ |user| user.first_name + " " + user.last_name }
  end

  def get_html_list_of_voters
    html_list = ""
    self.get_list_voters.each do |voter|
      html_list << "<li> #{voter} </li>"
    end
    return "<ul> #{html_list} </ul>"
  end
end
