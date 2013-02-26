class AffiliatedUser < ActiveRecord::Base
  attr_accessible :suit, :username

  def has_access_to_package(package_id)
    logger.info("Checking access for username: #{username}")
    inv_user = InvUser.where(username: username["username"]).first
    ConsumerPaidPackage.check_paid_for(inv_user.id, package_id)
  end
end
