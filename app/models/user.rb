class User < ActiveRecord::Base

#  has_many :fights
  has_many :attacks, :class_name => 'Fight', :foreign_key => "attacker_id", inverse_of: :attacker
  has_many :defends, :class_name => 'Fight', :foreign_key  => "defender_id", inverse_of: :defender

  has_one :rank
  # Include default devise modules. Others available are:

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
