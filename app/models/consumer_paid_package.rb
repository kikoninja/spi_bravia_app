class ConsumerPaidPackage < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  def self.check_paid_for(user_id, package_id)
    cpp = where("consumer_id = ? and package_id = ?", user_id, package_id).first
    return false if cpp.nil? || cpp.valid_until < Time.now
    true
  end

  def valid_until
    Chronic.parse("#{period} from now", :now => created_at)
  end
  
end
