# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do
  resources :collection_avatars
  resource :featured_collection, only: [:create, :destroy]
  mount Orcid::Engine => "/orcid"
  mount BrowseEverything::Engine => '/browse'
  mount Qa::Engine => '/authorities'

  mount Riiif::Engine => '/images'

  mount Blacklight::Engine => '/'

  authenticate :user, (->(u) { u.admin? }) do
    mount Sidekiq::Web => '/sidekiq'
  end

  concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: "registrations" }

  mount Hydra::RoleManagement::Engine => '/'

  resources :welcome, only: 'index'
  resources :welcome_page, only: [:index, :create]
  root 'hyrax/homepage#index'
  curation_concerns_basic_routes do
    member do
      get :manifest
    end
  end
  curation_concerns_embargo_management
  concern :exportable, Blacklight::Routes::Exportable.new

  get 'about' => 'static#about'
  get 'help' => 'static#help'
  get 'coll_policy' => 'static#coll_policy'
  get 'format_advice' => 'static#format_advice'
  get 'faq' => 'static#faq'
  get 'distribution_license' => 'static#distribution_license'
  get 'documenting_data' => 'static#documenting_data'
  get 'creators_rights' => 'static#creators_rights'
  get 'student_work_help' => 'static#student_work_help'
  get 'advisor_guidelines' => 'static#advisor_guidelines'
  get 'student_instructions' => 'static#student_instructions'
  get 'doi_help' => 'static#doi_help'
  get 'login' => 'static#login'

  # route for custom error pages issue #1056
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#server_error', via: :all

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  match 'show/:id' => 'common_objects#show', via: :get, as: 'common_object'

  resources :classify_concerns, only: [:new, :create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'hyrax/homepage#index'

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

  # This must be the very last route in the file because it has a catch-all route for 404 errors.
  # This behavior seems to show up only in production mode.
  mount Hyrax::Engine => '/'
end
