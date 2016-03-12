class Group < ActiveRecord::Base
	belongs_to :user
	has_many :samples
  has_many :keywords, through: :samples
end