class Invite < ActiveRecord::Base
  belongs_to :trip

  attr_accessor :token, :host_id
end
