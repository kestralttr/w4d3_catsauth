class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true

  before_validation :ensure_session_token

  def self.find_by_credentials(username,password)
    user = User.find_by(username: username)
    if user
      return user if user.is_password?(password)
    end
    nil
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
  end

  def ensure_session_token
    @session_token ||= self.session_token = SecureRandom.urlsafe_base64
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    self.save!
  end

  def is_password?(password)
    existing_pass = BCrypt::Password.new(self.password_digest)
    existing_pass.is_password?(password)
  end


end
