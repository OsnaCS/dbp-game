class User < ActiveRecord::Base
  has_one :rank, dependent: :destroy
  has_many :science_instances, dependent: :destroy
  has_many :sciences, :through => :science_instances
  has_many :user_ships
  has_many :ships, :through => :user_ships   
  has_many :notifications
  has_many :messages, through: :notifications
  after_initialize :init


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

  #f:<condition_id>:<level>,*
  def check_condition(conditions)
    condition_split = conditions.split(",")

    condition_split.each do |condition|
      condition_elements = condition.split(":")
      if(condition_elements[0].eql? "f")
        instance = ScienceInstance.find_by(:user_id => self.id, :science_id => Science.find_by(:science_condition_id => condition_elements[1]).id)
        if not (instance.level >= condition_elements[2].to_i)
          return false
        end
      end
    end
    return true
  end

  def is_researching()
    science_instances.each do |instance|
      if not(instance.start_time.nil?)
        return true
      end
    end
    return false
  end

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

  def is_user
    return right_level >= 0
  end

  def is_premium_user
    return right_level >= 1
  end

  def is_moderator
    return right_level >= 2
  end

  def is_admin
    return right_level >= 3
  end

  def is_superadmin
    return right_level >= 4
  end

  private
    def init
      Science.all.each do |science|
        if not(science_instances.exists?(:science_id => science.id, :user_id => self.id))
          science_instances.build(science: science, level: 0)
        end
      end
    end
end
