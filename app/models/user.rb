class User < ApplicationRecord
  has_secure_password
  validates :email, presence:true, uniqueness:true
  validates :username, presence:true, uniqueness:true
  before_create{generate_token(:remember_token)}
  has_many :posts
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
      self[column] = User.digest(self[column])
    end while User.exists?(column => self[column])
  end

  # Remembers a user in the database for use in persistent sessions.
  #def remember
    #self.remember_token = User.new_token
    #update_attribute(:remember_token, User.digest(remember_token))
  #end

end
