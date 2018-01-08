class Wiki < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  
  default_scope { order('created_at DESC') }
end
