Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount HyperMesh::Engine => '/rr'

  devise_for :users
  devise_for :admins

  root to: 'home#app'
end
