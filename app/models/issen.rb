class Issen < ActiveRecord::Base

  validates :body, length: { maximum: 800 }, presence: true
    
  belongs_to :user
  
  belongs_to :tanka
  
end
