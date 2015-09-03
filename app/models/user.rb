class User < ActiveRecord::Base
<<<<<<< HEAD
#  has_many :fights
  has_many :attacks, :class_name => 'Fight', :foreign_key => "attacker_id", inverse_of: :attacker
  has_many :defends, :class_name => 'Fight', :foreign_key  => "defender_id", inverse_of: :defender
=======
  has_one :rank
  # Include default devise modules. Others available are:
>>>>>>> 49e203af40c0b0d4db52a6685eb18a6436517bcf
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
