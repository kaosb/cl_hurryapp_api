class ActivitiesController < ApplicationController

	def show
		if !params[:token].nil?
			user = User.find_by_token(params[:token])
			render :json => { :status => true, :message => "Las actividades del usuario registradas.", :activities => user.activities }, :status => 200
		else
			render :json => { :status => false, :message => "El usuario no existe." }, :status => 401
		end
	end

end
