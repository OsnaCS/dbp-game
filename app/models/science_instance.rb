class ScienceInstance < ActiveRecord::Base
  belongs_to :science
  belongs_to :user
end
