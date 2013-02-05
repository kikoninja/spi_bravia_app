class ConsumerPaidPackage < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  def self.check_paid_for(user_id, package_id)
    where("consumer_id = ? and package_id = ?", user_id, package_id).first
  end
  
end
