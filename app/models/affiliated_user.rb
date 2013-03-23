class AffiliatedUser < ActiveRecord::Base
  attr_accessible :suit, :username

  def has_access_to_package(package_id)
  	regex = /username: (.*)/
  	user_name = username.scan(regex).first.first
    logger.info("Checking access for username: #{user_name}")
    inv_user = InvUser.where(username: user_name).first
    ConsumerPaidPackage.check_paid_for(inv_user.id, package_id)
  end
end
