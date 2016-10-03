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
				get '/:token/goals' => 'users#get_goals'
				get '/:token/subscriptions' => 'users#get_subscriptions'
			end
			scope '/activities' do
				get '/:token' => 'activities#show'
				get '/:token/:time_window_slug' => 'activities#show_by_time_window'
				post '/:token' => 'activities#add'
			end
			scope '/goals' do
				get '/:id' => 'goals#show'
			end
			scope '/partners' do
				get '/:id' => 'partners#show'
				get '/type/:slug_type' => 'partners#show_slug_type'
			end
			scope '/subscriptions' do
				post '/:partner_id/:token' => 'subscriptions#subscribe'
			end
		end
	end

end
