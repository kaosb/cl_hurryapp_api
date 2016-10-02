class GoalsController < ApplicationController

	def show
		goal = Goal.find(params[:id])
		if goal
			render :json => { :status => true, :message => "La meta existe.", :goal => goal }, :status => 200
		else
			render :json => { :status => false, :message => "La meta no existe." }, :status => 401
		end
	end

end
