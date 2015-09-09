class User < ActiveRecord::Base
  has_one :rank
  has_many :user_ships
  has_many :ships, :through => :user_ships   
  has_many :notifications
  has_many :messages, through: :notifications


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  attr_accessor :login

  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }


  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions.to_h).first
      end
    end

  def login=(login)
    @login = login
  end
  
  def login
    @login || self.username || self.email
  end

  
  def create_ship(ship_name)
    s = self.ships.build(ship_name)
    self.user_ships.build(user: self, ship: s)
    return s
  end

  def select_ship(shipID)
    self.activeShip=shipID
    self.save
  end

end
