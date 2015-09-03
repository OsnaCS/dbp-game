class User < ActiveRecord::Base
  has_one :rank
  has_many :science_instances
  has_many :scienses, :through => :science_instances

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
