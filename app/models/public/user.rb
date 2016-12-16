class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :lockable, :rememberable, :trackable, :validatable  unless RUBY_ENGINE == 'opal'

  has_many :clocks

end
