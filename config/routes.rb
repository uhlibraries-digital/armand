require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Hybridge::Engine => '/hybridge'
  concern :oai_provider, BlacklightOaiProvider::Routes.new

  authenticate :user, lambda { |u| u.can? :read, :admin_dashboard } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  # mount Riiif::Engine => 'images', as: :riiif
  mount Blacklight::Engine => '/'
  
  concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :oai_provider
    concerns :searchable
  end

  if Settings.cas.active
    devise_for :users, :controllers => { sessions: 'devise/cas_sessions' }
  else
    devise_for :users
  end

  mount Qa::Engine => '/authorities'
  mount Hyrax::Engine, at: '/'
  resources :welcome, only: 'index'
  root 'hyrax/homepage#index'
  curation_concerns_basic_routes
  concern :exportable, Blacklight::Routes::Exportable.new

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  namespace :hyrax, path: :concern do
    concerns_to_route.each do |curation_concern_name|
      namespaced_resources curation_concern_name, only: [] do
        member do
          get :thumbnail
        end
      end
    end
  end

  get '/collections/:id/thumbnail' => 'hyrax/collections#thumbnail'

  post '/feedback' => 'feedback#generate'

  get '/404' => 'error#missing'
  get '/500' => 'error#internalerror'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
