class UsersController < ApplicationController

	def show
		user = User.where(token: params[:token])
		if user
			render :json => { :status => true, :message => "El usuario existe.", :user => user }, :status => 200
		else
			render :json => { :status => false, :message => "El usuario no existe." }, :status => 401
		end
	end

	def create
		# Bloque para guardar archivo en caso de ser pertinente.
		if !params[:image].nil?
			uploaded_io = params[:image]
			filename = 'profile_img_'+Time.now.to_i.to_s+'_'+uploaded_io.original_filename.gsub(" ", '_').downcase!
			File.open(Rails.root.join('public', 'uploads', filename), 'wb') do |file|
				file.write(uploaded_io.read)
			end
			image_url = request.base_url + '/uploads/' + filename
			params[:image_url] = image_url
		end
		params.delete :image
		# Creo el nuevo registro, con la informacion aportada.
		user = User.new(user_params)
		# Aseguro la password y creo un token para el usuario.
		user.password = User.encript(params[:password])
		if user.save
			render :json => { :status => true, :message => "La nueva cuenta fue creada.", :token => user.token }, :status => 201
		else
			render :json => { :status => false, :message => "No fue posible posible crear la nueva cuenta.", :errors => user.errors }, :status => 401
		end
	end

	def update
		user = User.find_by_token(params[:token])
		if user.update_attributes(user_params)
			if !params[:image].nil?
				uploaded_io = params[:image]
				filename = 'profile_img_'+Time.now.to_i.to_s+'_'+uploaded_io.original_filename.gsub(" ", '_').downcase!
				File.open(Rails.root.join('public', 'uploads', filename), 'wb') do |file|
					file.write(uploaded_io.read)
				end
				user.image_url = request.base_url + '/uploads/' + filename
				user.save
			end
			render :json => { :status => true, :message => "La cuenta fue actualizada." }, :status => 200
		else
			render :json => { :status => false, :message => "No fue posible actualizar la cuenta." }, :status => 401
		end
	end

	def login
		if !params[:email].nil? && !params[:password].nil?
			user = User.where(email: params[:email], password: User.encript(params[:password]))
			if !user.empty?
				render :json => { :status => true, :message => "Usuario autenticado.", :token => user.first.token }, :status => 200
			else
				render :json => { :status => false, :message => "No fue posible posible autenticar al usuario." }, :status => 200
			end
		else
			render :json => { :status => false, :message => "No fue posible posible autenticar al usuario.", :errors => "Parametros insuficientes." }, :status => 401
		end
	end

	def validate
		response = Array.new
		# Verificamos la disponibilidad del correo.
		if !params[:email].nil?
			if !User.exists?(email: params[:email])
				response << { email: "available" }
			else
				response << { email: "not available" }
			end
		end
		# Verificamos la disponibilidad del nick_name.
		if !params[:nick_name].nil?
			if !User.exists?(nick_name: params[:nick_name])
				response << { nick_name: "available" }
			else
				response << { nick_name: "not available" }
			end
		end
		# Verifico si exisque algo en el objeto respuesta.
		if !response.empty?
			render :json => { :status => true, :message => "Parametros correctos.", :attributes => response }, :status => 200
		else
			render :json => { :status => false, :message => "Parametros insuficientes." }, :status => 401
		end
	end

	def get_goals
		user = User.find_by_token(params[:token])
		if user
			render :json => { :status => true, :message => "El usuario existe.", :goals => user.user_achieved_goals }, :status => 200
		else
			render :json => { :status => false, :message => "El usuario no existe." }, :status => 401
		end
	end

	def get_subscriptions
		user = User.find_by_token(params[:token])
		if user
			render :json => { :status => true, :message => "El usuario existe.", :subscriptions => user.subscriptions }, :status => 200
		else
			render :json => { :status => false, :message => "El usuario no existe." }, :status => 401
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
			:device_so,
			:gender,
			:age,
			:height,
			:weight,
			:purpose,
			:purpose_quantity,
			:image_url,
			:status
			)
		end

end
