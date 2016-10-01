Rails.application.routes.draw do
	root to: "application#welcome"

	scope '/api' do
		scope '/v1' do
			scope '/users' do
				post '/' => 'users#create'
				post '/login' => 'users#login'
				# get '/' => 'doctor_api#show'
				# patch '/' => 'doctor_api#update'
				# post '/pushnotification' => 'doctor_api#pushnotification'
			end
		end
	end

end
