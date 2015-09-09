class UserIcon < ActiveRecord::Base
  has_attached_file :image
  # validates :image, attachment_presence: true   
  validates :image, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
