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
		# Creo el nuevo registro, con la informacion aportada.
		params.delete :image
		user = User.new(user_params)
		# Aseguro la password y creo un token para el usuario.
		user.password = Digest::SHA1.hexdigest(params[:password])
		if user.save
			render :json => { :status => true, :message => "La nueva cuenta fue creada.", :token => user.token }, :status => 201
		else
			render :json => { :status => false, :message => "No fue posible posible crear la nueva cuenta.", :errors => user.errors }, :status => 401
		end
	end

	def update
		if @doctor.update_attributes(user_params)
			render :json => { :status => true, :message => "El medico fue modificado." }, :status => 200
		else
			render :json => { :status => false, :message => "No fue posible actualizar el medico." }, :status => 401
		end
	end

	private

		def user_params
			params.permit(
			:first_name,
			:last_name,
			:nick_name,
			:email,
			:password,
			:token,
			:deviceid,
			:device,
			:gender,
			:age,
			:height,
			:weight,
			:purpose,
			:purpose_unit,
			:purpose_quantity,
			:image_url,
			:status
			)
		end

end
