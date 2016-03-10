class User < ActiveRecord::Base
	has_many :groups
	has_many :samples

	has_secure_password


end
