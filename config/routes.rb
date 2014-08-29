CurateApp::Application.routes.draw do
  #root 'catalog#index'
  root 'page_requests#view_presentation'
  Blacklight.add_routes(self)
  HydraHead.add_routes(self)
    devise_for :users, controllers: { sessions: :sessions, registrations: :registrations}

  devise_scope :users do
    get "user_root", to: "catalog#index"
  end  
  
  curate_for

  get 'terms_request' => 'page_requests#view_terms'
  get 'about_request' => 'page_requests#view_about'
  get 'presentation_request' => 'page_requests#view_presentation'
  get 'coll_pol_request' => 'page_requests#view_coll_pol'
  get 'pres_pol_request' => 'page_requests#view_pres_pol'
  get 'fair_use_request' => 'page_requests#view_fair_use'
  get 'faq_request' => 'page_requests#view_faq'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
