class Kogyo < ActiveRecord::Base
    
      belongs_to :user

      has_many :rengas
    
end
