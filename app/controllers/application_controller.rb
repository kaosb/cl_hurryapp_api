class ApplicationController < ActionController::API

	def welcome
		render :json => { :status => true, :message => "API hurryApp." }, :status => 200
	end

end
