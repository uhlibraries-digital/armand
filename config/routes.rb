require 'sidekiq/web'

Rails.application.routes.draw do
  mount Hybridge::Engine => '/hybridge'

  authenticate :user, lambda { |u| u.can? :read, :admin_dashboard } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  mount Riiif::Engine => 'images', as: :riiif
  mount Blacklight::Engine => '/'
  
  concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
