class Sample < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
	has_many :reports
  has_many :keywords
end