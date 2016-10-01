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
		if !params[:auth_password].nil? && !params[:uuid].nil? && Doctor.exists?(uuid: params[:uuid], password: params[:auth_password])
			doctor = Doctor.find_by_uuid(params[:uuid])
			# Si es doctor obtengo sus consultores asociados.
			if !doctor.is_consultant
				medical_consultants = DoctorMedicalConsultant.where(doctor_id: doctor.id)
				consultants = Array.new
				medical_consultants.each do |consultant|
					temp_consultant = Doctor.find_by_id(consultant.medical_consultant_id)
					consultants << temp_consultant
				end
			end
			render :json => { 
				:status => true,
				:message => "Te autenticaste de forma exitosa con tu clave personalizada.",
				:token => doctor.password_token,
				:cardPassword => false,
				:doctor => doctor.as_json(:except => [:id, :uuid, :rut, :name, :lastname, :medical_speciality_id, :email, :phone, :password_token, :password, :default_password, :created_at, :updated_at, :consultant_name_1, :consultant_name_2, :consultant_name_3, :consultant_name_4, :status]),
				:consultants => !consultants.nil? ? consultants : nil
			}, :status => 200
		elsif !params[:auth_password].nil? && Doctor.exists?(default_password: params[:auth_password])
			doctor = Doctor.find_by_default_password(params[:auth_password])
			if (doctor.uuid.nil? && doctor.password_token.nil?) || (!doctor.uuid.nil? && doctor.uuid != params[:uuid])
				# valido si la password no fue quemada anteriormente.
				passwords_reserved = ['111111bb', '222222bb', '333333bb', '444444bb', '555555bb', '666666bb', '777777bb', '888888bb', '999999bb', '1010101bb', '1111111bb', '1222222bb', '1333333bb', '1444444bb', '1555555bb', '1666666bb', '1777777bb', '1888888bb', '1999999bb', '10101010bb', '11111111bb', '22222222bb', '33333333bb', '44444444bb', '55555555bb', '66666666bb', '77777777bb', '88888888bb', '99999999bb', '30303030bb']
				if doctor.burned_password == false || passwords_reserved.include?(params[:auth_password])
					doctor.burned_password = true
					doctor.uuid = params[:uuid]
					doctor.password_token = SecureRandom.hex
					if doctor.save
						render :json => { :status => true, :message => "El medico fue activado.", :token => doctor.password_token, :cardPassword => true }, :status => 200
					else
						render :json => { :status => false, :message => "El medico no fue activado." }, :status => 500
					end
				else
					render :json => { :status => false, :message => "No fue posible autenticar y/o activar al medico con los datos proporcionados ya que el password fue quemado." }, :status => 401
				end
			else
				# Si es doctor obtengo sus consultores asociados.
				if !doctor.is_consultant
					medical_consultants = DoctorMedicalConsultant.where(doctor_id: doctor.id)
					consultants = Array.new
					medical_consultants.each do |consultant|
						temp_consultant = Doctor.find_by_id(consultant.medical_consultant_id)
						consultants << temp_consultant
					end
				end
				render :json => { 
					:status => true,
					:message => "Te autenticaste de forma exitosa.",
					:token => doctor.password_token,
					:cardPassword => true,
					:doctor => doctor.as_json(:except => [:id, :uuid, :rut, :name, :lastname, :medical_speciality_id, :email, :phone, :password_token, :password, :default_password, :created_at, :updated_at, :consultant_name_1, :consultant_name_2, :consultant_name_3, :consultant_name_4, :status]),
					:consultants => !consultants.nil? ? consultants : nil
				}, :status => 200
			end
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
