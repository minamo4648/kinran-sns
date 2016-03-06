class RengaVotership < ActiveRecord::Base
  belongs_to :user
  belongs_to :renga
  belongs_to :kogyo
end