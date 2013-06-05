class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :oauth2_providable, :oauth2_password_grantable,
         :oauth2_refresh_token_grantable, :oauth2_authorization_code_grantable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :trips
  has_one :current_trip, class_name: 'Trip', conditions: "status = '#{Trip::PENDING}'"
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
