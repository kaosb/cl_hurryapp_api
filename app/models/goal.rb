class Goal < ApplicationRecord

	belongs_to :partner
	has_many :user_achieved_goals

end
