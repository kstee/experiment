class User < ActiveRecord::Base
  include Clearance::User

  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication,auth_hash)
    # byebug
    create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.birthday = auth_hash["extra"]["raw_info"]["birthday"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.password = SecureRandom.base64(8)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end
end
