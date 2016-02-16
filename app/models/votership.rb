class Votership < ActiveRecord::Base
    
  belongs_to :user
  belongs_to :tanka
  belongs_to :dai
    
end
