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

  def self.to_csv
    CSV.generate do |csv|
      # column_namesはカラム名を配列で返す
      # 例: ["id", "name", "price", "released_on", ...]
      #csv << ["body"]
      all.each do |tanka|
        # attributes はカラム名と値のハッシュを返す
        # 例: {"id"=>1, "name"=>"レコーダー", "price"=>3000, ... }
        # valudes_at はハッシュから引数で指定したキーに対応する値を取り出し、配列にして返す
        # 下の行は最終的に column_namesで指定したvalue値の配列を返す
        csv << tanka.attributes.values_at("body","user_id")
      end
    end
  end
    
end
