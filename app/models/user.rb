class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  
  before_save { self.role ||= :standard }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  enum role: [:standard, :premium, :admin]       
end
