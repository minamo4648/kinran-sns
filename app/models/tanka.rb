class Tanka < ActiveRecord::Base

  validates :body, length: { maximum: 60 }, presence: true

  has_many :voterships, dependent: :destroy
  has_many :users, through: :voterships
  
  has_many :comments, dependent: :destroy

  belongs_to :user
  
  belongs_to :dai
  
  has_many :issens  

  has_many :kins, class_name: "Kin", foreign_key: "tanka_id", dependent: :destroy
  has_many :kin_users , through: :kins, source: :user
  
  has_many :rans, class_name: "Ran", foreign_key: "tanka_id", dependent: :destroy
  has_many :ran_users , through: :rans, source: :user

  has_many :shos, class_name: "Sho", foreign_key: "tanka_id", dependent: :destroy
  has_many :sho_users , through: :shos, source: :user
    
end
