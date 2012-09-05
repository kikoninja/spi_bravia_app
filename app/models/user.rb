class User < ActiveRecord::Base
  # Authentication
  has_secure_password

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  def is_admin?
    admin
  end

end
