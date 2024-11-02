Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/user', controllers: {
    registrations: 'auth/user/registrations',
    sessions: 'auth/user/sessions'
  }

  namespace :api do
    namespace :v1 do
      namespace :worker do
        put 'part/change_status/:id', to: 'sub_parts#change_status'
      end
      namespace :qc do
        put 'part/change_stage/:id', to: 'sub_parts#change_stage'
      end

      resources :projects do
        resources :sub_parts do
          collection do
            get :stats
          end
        end
      end
    end
  end
end