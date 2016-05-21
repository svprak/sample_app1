class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  # add this for functionality of a secure password
  has_secure_password
    # The ability to save a securely hashed password_digest attribute to the database
    # A pair of virtual attributes18 (password and password_confirmation), including presence validations upon object creation and a validation requiring that they match
    # An authenticate method that returns the user when the password is correct (and false otherwise)
  validates :password, presence: true, length:{minimum:2}

    # Returns the hash digest of the given string.
  def User.digest(string)
   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
   BCrypt::Password.create(string, cost: cost)
  end
 # For the feature of remembering user login in the cookie
 # This will return a random tooken given by SecureRandom with 64bits Base
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # RETURN TRUE IF THE GIVEN TOKEN MATCHES THE DIGEST
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  # forget a user from the cookie
  def forget
    update_attribute(:remember_digest, nil)
  end

end
