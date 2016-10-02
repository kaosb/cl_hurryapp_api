class User < ApplicationRecord

	has_secure_token

	has_many :activities, dependent: :destroy
	has_many :subscriptions, dependent: :destroy
	has_many :user_achieved_goals, dependent: :destroy

	validates_presence_of :nick_name, :message => "Es necesario un nombre de usuario."
	validates_presence_of :email, :message => "Es necesario una direccion de correo electronico."
	validates_presence_of :first_name, :message => "Es necesario indicar tus nombres."
	validates_presence_of :last_name, :message => "Es necesario indicar tus apellidos."
	validates_uniqueness_of :nick_name, :message => "El nombre de usuario que indicaste ya existe."
	validates_uniqueness_of :email, :message => "La direccion de correo electronico que indicaste ya existe."

	# Encriptar el password
	def self.encript(password)
		Digest::SHA1.hexdigest(password)
	end

end
