class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
has_many :ships 
validates_length_of :ships, maximum: 9
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
