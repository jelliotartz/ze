class User < ActiveRecord::Base
	has_many :groups
	has_many :samples

  validates :email, presence: true, uniqueness: true

	has_secure_password

end
