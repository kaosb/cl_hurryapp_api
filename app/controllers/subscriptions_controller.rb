class SubscriptionsController < ApplicationController

	def subscribe
		partner = Partner.find(params[:partner_id])
		user = User.find_by_token(params[:token])
		if Subscription.exists?(user_id: user.id, partner_id: partner.id)
			subscription = Subscription.where(user_id: user.id, partner_id: partner.id).first
			subscription.user_id = user.id
			subscription.partner_id = partner.id
			if subscription.status
				subscription.status = false
			else
				subscription.status = true
			end
			subscription.save
			render :json => { :status => true, :message => "La suscripcion del usuario fue actualizada.", :subscription => subscription }, :status => 200
		else
			subscription = Subscription.new(subscription_params)
			subscription.user_id = user.id
			render :json => { :status => true, :message => "La suscripcion del usuario fue registrada.", :subscription => subscription }, :status => 200
		end
	end

	private

		def subscription_params
			params.permit(
			:partner_id
			)
		end

end
