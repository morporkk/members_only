class User < ApplicationRecord
  before_save   :downcase_email
  before_create :create_remember_digest

  attr_accessor :remember_token

  validates :name,  presence: true, length: { maximum: 54 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(token)
      Digest::SHA1.hexdigest(token)
    end
  end

  private

  # Before filters
  def downcase_email
    email.downcase!
  end

  # Remembers a user in the db for use in persisent sessions
  def create_remember_digest
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token)
  end


end
