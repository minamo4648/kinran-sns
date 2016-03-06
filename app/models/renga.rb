class Renga < ActiveRecord::Base

  belongs_to :user

  belongs_to :kogyo
    
  has_many :renga_voterships, dependent: :destroy
  has_many :vote_users, through: :renga_voterships, source: :user    
    
end
