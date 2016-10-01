class UsersController < ApplicationController

	def show
		person = Doctor.find_by_password_token(params[:auth_token])
		if person
			# Si es doctor obtengo sus consultores asociados.
			if !person.is_consultant
				medical_consultants = DoctorMedicalConsultant.where(doctor_id: person.id)
				consultants = Array.new
				medical_consultants.each do |consultant|
					temp_consultant = Doctor.find_by_id(consultant.medical_consultant_id)
					consultants << temp_consultant
				end
			end
			render :json => { :status => true, :message => "El medico existe.", :person => person, :consultants => !consultants.nil? ? consultants : nil }, :status => 200
		else
			render :json => { :status => false, :message => "El medico no existe." }, :status => 401
		end
	end

	def create

		if !params[:nick_name].nil? && !params[:email].nil? && !params[:password].nil?
			#&& User.exists?(nick_name: params[:nick_name]) && User.exists?(email: params[:email])
			render :json => { :status => true, :message => "Se creo la cuenta.." }, :status => 201
		else
			render :json => { :status => false, :message => "No fue posible autenticar y/o activar al medico con los datos proporcionados." }, :status => 401
		end

	end

	def update
		if @doctor.update_attributes(doctor_params)
			render :json => { :status => true, :message => "El medico fue modificado." }, :status => 200
		else
			render :json => { :status => false, :message => "No fue posible actualizar el medico." }, :status => 401
		end
	end

end
