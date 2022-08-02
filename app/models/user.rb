class User < ApplicationRecord
  validates :first_name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 3 }
  validates :email, uniqueness: { case_sensitive: false }
  before_save { email.downcase }

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    lower_case = email.downcase
    strip_email = lower_case.strip
    @user = User.find_by_email(strip_email)

    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end

end
