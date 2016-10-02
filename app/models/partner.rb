class Partner < ApplicationRecord

	has_many :subscriptions, dependent: :destroy
	has_many :goals, dependent: :destroy

end
