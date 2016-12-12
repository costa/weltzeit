Rails.application.routes.draw do
  mount HyperMesh::Engine => '/rr'

  root to: 'home#app'
end
