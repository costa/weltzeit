Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount HyperMesh::Engine => '/rr'

  root to: 'home#app'
end
