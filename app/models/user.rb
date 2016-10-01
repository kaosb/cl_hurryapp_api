class User < ApplicationRecord

	validates_presence_of :nick_name, :message => "Es necesario un nombre de usuario."
	validates_presence_of :mail, :message => "Es necesario una direccion de correo electronico."
	validates_presence_of :first_name, :message => "Es necesario indicar tus nombres."
	validates_presence_of :last_name, :message => "Es necesario indicar tus apellidos."
	validates_uniqueness_of :nick_name, :message => "El nombre de usuario que indicaste ya existe."
	validates_uniqueness_of :email, :message => "La direccion de correo electronico que indicaste ya existe."

end
