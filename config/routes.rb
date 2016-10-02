Rails.application.routes.draw do
	root to: "application#welcome"

	scope '/api' do
		scope '/v1' do
			scope '/users' do
				post '/' => 'users#create'
				post '/login' => 'users#login'
				patch '/:token' => 'users#update'
				get '/:token' => 'users#show'
				post '/validate' => 'users#validate'
			end
		end
	end

end
