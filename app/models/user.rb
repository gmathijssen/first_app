TYPE_VALUES = { 1 => 'admin', 2 => 'power user', 3 => 'viewer' }
ADMIN = 1
VIEWER = 3

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :user_type, :password, :password_confirmation
    
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,:presence => true,
                    :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false}
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence => true,
                   :confirmation => true,
                   :length       => { :within => 6..40 }
  has_many :posts
  has_many :comments
  has_many :microposts
                   
  before_save :encrypt_password, :default_values

  def default_values
    self.user_type ||= VIEWER
  end
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil  if user.nil?
    return user if user.salt == cookie_salt
  end

  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end