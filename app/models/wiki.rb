class Wiki < ApplicationRecord
  belongs_to :user, dependent: :destroy
  
  default_scope { order('created_at DESC') }
end
