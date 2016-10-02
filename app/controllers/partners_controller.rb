class PartnersController < ApplicationController

	def show
		partner = Partner.find(params[:id])
		if partner
			render :json => { :status => true, :message => "El partner existe.", :partner => partner }, :status => 200
		else
			render :json => { :status => false, :message => "No existe el partner." }, :status => 401
		end
	end

	def show_slug_type
		partners = Partner.find_by_slug_type(params[:slug_type])
		if partners
			render :json => { :status => true, :message => "Existen partner del tipo solicitado.", :partners => partners }, :status => 200
		else
			render :json => { :status => false, :message => "No existen partner del tipo solicitado." }, :status => 401
		end
	end

end
