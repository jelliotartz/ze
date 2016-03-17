class User < ActiveRecord::Base
	has_many :samples
  has_many :keywords, through: :samples

  validates :email, presence: true, uniqueness: true

	has_secure_password

end
