class ActivitiesController < ApplicationController

	def show
		if !params[:token].nil?
			user = User.find_by_token(params[:token])
			render :json => { :status => true, :message => "Las actividades del usuario registradas.", :activities => user.activities }, :status => 200
		else
			render :json => { :status => false, :message => "Parametros insuficientes." }, :status => 401
		end
	end

	def show_by_time_window
		if !params[:token].nil? && !params[:time_window_slug].nil?
			today = Date.today
			case params[:time_window_slug]
			when 'week'
				date_from = today.at_beginning_of_week
				date_to = today.at_end_of_week
			when 'month'
				date_from = today.at_beginning_of_month
				date_to = today.at_end_of_month
			end
			if params[:time_window_slug] === 'today'
				user = User.where(token: params[:token]).joins(:activities).where(activities: {date: today})
			else
				user = User.where(token: params[:token]).joins(:activities).where(activities: {date: date_from..date_to})
			end
			render :json => { :status => true, :message => "Las actividades del usuario registradas.", :activities => user.as_json(:include => :activities) }, :status => 200
		else
			render :json => { :status => false, :message => "El usuario no existe." }, :status => 401
		end
	end

end
