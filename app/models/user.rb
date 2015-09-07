class User < ActiveRecord::Base
  has_one :rank, dependent: :destroy
  has_many :science_instances, dependent: :destroy
  has_many :sciences, :through => :science_instances
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
      else
        return false
      end
    end
    return true
  end

  def can_research(instance)
    #returnvar = ScienceInstance.where(science_id: instance.science_id, user_id: instance.user_id).first.start_time.nil?
    #return returnvar
    return instance.start_time.nil?
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

  private
    def init
      Science.all.each do |science|
        if not(science_instances.exists?(:science_id => science.id, :user_id => self.id))
          science_instances.build(science: science, level: 0)
        end
      end
    end
end
