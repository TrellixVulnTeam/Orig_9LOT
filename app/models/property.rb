class Property < ActiveRecord::Base
  has_many :proposals
  has_many :users,through: :proposals
end
