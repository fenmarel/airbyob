class User < ActiveRecord::Base
  attr_reader :password

  before_validation :ensure_session_token
  validates :username, :email, :presence => true, :uniqueness => true
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :password_digest, :session_token, :presence => true

  has_many :sites

  def self.generate_token
    SecureRandom::urlsafe_base64(24)
  end

  def self.find_by_credentials(login_params)
    user = User.find_by_username(login_params[:username])

    if user && user.is_password?(login_params[:password])
      user
    else
      nil
    end
  end

  def password=(plaintext)
    @password = plaintext
    self.password_digest = BCrypt::Password.create(plaintext)
  end

  def is_password?(plaintext)
    BCrypt::Password.new(self.password_digest).is_password?(plaintext)
  end

  def reset_session_token!
    self.session_token = self.class.generate_token
    self.save

    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_token
  end
end
