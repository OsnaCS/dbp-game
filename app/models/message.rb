class Message < ActiveRecord::Base

has_many :notifications
has_many :users, through: :notifications

end
