class User < ActiveRecord::Base
  has_many :attacks, class_name => 'Fight', foreign_key => 'attacker_id'
  has_many :defenders, class_name => 'Fight', foreign_key => 'defender_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
