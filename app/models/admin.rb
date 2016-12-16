class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable, :timeoutable, :trackable, :validatable
end
