class Subscription < ApplicationRecord

	belongs_to :user
	belongs_to :partner

end
