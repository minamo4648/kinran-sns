class Comment < ActiveRecord::Base
    
  belongs_to :user
  
  belongs_to :tanka

validates :body, presence: true, length: { maximum: 140 }
    
end
