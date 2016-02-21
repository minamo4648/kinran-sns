class Issen < ActiveRecord::Base

  validates :body, length: { maximum: 2000 }, presence: true
    
  belongs_to :user
  
  belongs_to :tanka
  
end
