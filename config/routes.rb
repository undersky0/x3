Uu2::Application.routes.draw do
  resources :contact_froms, only: [:index, :create]
  get "contact" => "contact_forms#index"

    root :to => 'localfeeds#index'
    get "search/index"
    get "search/query"
    get "search/tokenquery"
    get "friendmap/index"
    get 'home', to: 'home#index'
    get "invites/user_invite" => 'invites#user_invite', :as => :user_invite
    resources :locations
    resources :prelaunches
    resources :events
    resources :attachables
    resources :galleries
    resources :pictures
    resources :profiles
    resources :memberships, :only => [:create, :destroy]
    resource :avatars
    resource :home, :only => [:index]
    resources :skills do
      resource :locations, only: [:index, :new, :create, :edit, :update]
    end
  
    resources :albums do
      resources :pictures do
        collection do
          post 'make_default'
        end
     end
    end
 
    resources :groups do
      resource :locations, only: [:index, :new, :create, :edit, :update]
      resources :albums
      collection do
        post :import
        get :autocomplete
      end
    end
  
    resources :localfeeds do
      resource :scribbles
      member do
        post 'localscribble', :action => :newlocalscribble
      end
    end

    devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
    match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
    
    resources :users do
      member do
        get 'crop', :action => :crop
      end
      resources :profiles do
        member do
          post 'namereg', :action => :namereg
        end
        collection do
          post 'uploadfoto', :action => :uploadfoto
        end
      end  
    end

    resources :scribbles do
          member do
            post 'localscribble', :action => :newlocalscribble
            get 'promote'
            post 'vote_for'
            post 'vote_against'
            post 'vote'
      end
      resources :comments 
    end
  
  
    resources :comments do 
      member do
        post 'vote'
      end
    end
       
    resources :friendships do
      collection do
        get 'request_fr',:as=>"addfriend"
        get 'accept',:as=>"accept_fr"
        get 'reject',:as=>"reject_fr"
      end
    end
    
    resources :invites do 
      collection do
        get 'invite'
        get 'accept'
        get 'decline'
        get 'addwatch'
        get 'removewatch'
        get 'join'
        get 'leave'
      end
    end
    
    resources :users do 
      collection do
        get 'usersearch', :as => "usersearch"
        get 'autocomplete'
        get 'showconnections'
      end
      member do
        get 'user_skills'
      end
    resource :locations, only: [:index, :new, :create, :edit, :update]
    resources :albums
    resources :skills
    end
    
    resources :invitations do
      collection do
        get 'sendinv', :as=> "invite"
        get 'cancel_inv', :as=> "cancel_invite"
        get 'accept', :as =>"accept_invite"
        get 'reject', :as => "reject_invite"
      end
    end
    
    resources :messages do
      member do
        post :new
      end
    end
    
    resources :conversations do
      member do
        post :reply
      end
     collection do
        post :trash
        post :untrash
        get :trashbin
        post :empty_trash
     end
    end
   

  
   get "/showusers/:id" => "users#showconnections", :as=>"showusers"
   mount Soulmate::Server, :at => '/sm'
   get "/usersearch/" => "users#usersearch", :as=>"usersearch"
   

   
  #map.resources :scribbles, :has_many => :comments

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
