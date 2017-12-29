class Wiki < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
