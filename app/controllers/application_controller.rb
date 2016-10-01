class ApplicationController < ActionController::API

	def welcome
		render :json => { :status => true, :message => "API hurryApp." }, :status => 200
	end

	def generateUniqueHexCode(codeLength)
		validChars = ("A".."F").to_a + ("0".."9").to_a
		length = validChars.size
		hexCode = ""
		1.upto(codeLength) { |i| hexCode << validChars[rand(length-1)] }
		hexCode
	end

end
