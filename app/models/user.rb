class User < ActiveRecord::Base
  has_one :rank
  has_many :science_instances
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
