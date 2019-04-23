Refinery::Core::Engine.routes.prepend do
  if Refinery::Redirections.enable_route_redirection
    get '/*path', to: 'redirections/redirections#redirect',
                  constraints: Refinery::Redirections::RoutesConstraint
  end

  namespace :redirections, path: '' do
    namespace :admin, path: Refinery::Core.backend_route do
      resources :redirections, except: :show
    end
  end
end
