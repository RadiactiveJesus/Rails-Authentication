class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  validates :email, presence:true, uniqueness:true
  validates :username, presence:true, uniqueness:true
  before_create{remember}
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_token, User.digest(remember_token))
  end

end
