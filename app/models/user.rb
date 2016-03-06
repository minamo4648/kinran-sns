require 'csv'   # csv操作を可能にするライブラリ
require 'kconv' # 文字コード操作をおこなうライブラリ

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable
         
  validates :name, length: { maximum: 20 }, presence: true
  validates :nickname, length: { maximum: 20 }  
  
  has_many :voterships, dependent: :destroy
  has_many :tankas, through: :voterships
  
  has_many :noteships, dependent: :destroy
  has_many :notices, through: :noteships

  has_many :renga_voterships, dependent: :destroy
  has_many :voted_rengas, through: :renga_voterships, source: :renga

  has_many :dais

  has_many :tankas

  has_many :comments

  has_many :issens

  has_many :rengas
  
  has_many :kogyos

  has_many :kins, class_name: "Kin", foreign_key: "user_id", dependent: :destroy
  has_many :kin_tankas , through: :kins, source: :tanka
  
  has_many :rans, class_name: "Ran", foreign_key: "user_id", dependent: :destroy
  has_many :ran_tankas , through: :rans, source: :tanka

  has_many :shos, class_name: "Sho", foreign_key: "user_id", dependent: :destroy
  has_many :sho_tankas , through: :shos, source: :tanka

  # CSVファイルを読み込み、ユーザーを登録する
  def import_csv(csv_file)
  # csvファイルを受け取って文字列にする
  csv_text = csv_file.read
    
  data = []

  #文字列をUTF-8に変換
    CSV.parse(Kconv.toutf8(csv_text)) do |row|
  
      user = User.new
      user.name    = row[0]  #csvの1列目を格納
      user.email   = row[1]  #csvの2列目を格納
      user.password   = row[2]  #csvの3列目を格納
      user.grade   = row[3]  #csvの4列目を格納
      user.gender  = row[4]  #csvの5列目を格納
      # passwordをいかにすべきか？
         
      user.save
    end
  end
  
  def kin(tanka)
    
    if kin_tankas.where(dai_id: tanka.dai_id).present?
      unkin(kin_tankas.where(dai_id: tanka.dai_id).first)
    end
    
    kins.find_or_create_by(tanka_id: tanka.id, dai_id: tanka.dai.id)   
  end

  def unkin(tanka)
    kins.find_by(tanka_id: tanka.id).destroy
  end

  def kin?(tanka)
    kin_tankas.include?(tanka)
  end
  
  def ran(tanka)
    
    if ran_tankas.where(dai_id: tanka.dai_id).present?
      unran(ran_tankas.where(dai_id: tanka.dai_id).first)
    end    
    
    rans.find_or_create_by(tanka_id: tanka.id, dai_id: tanka.dai.id)   
  end

  def unran(tanka)
    rans.find_by(tanka_id: tanka.id).destroy
  end

  def ran?(tanka)
    ran_tankas.include?(tanka)
  end

  def sho(tanka)
    
    if sho_tankas.where(dai_id: tanka.dai_id).present?
      unsho(sho_tankas.where(dai_id: tanka.dai_id).first)
    end
    
    shos.find_or_create_by(tanka_id: tanka.id, dai_id: tanka.dai.id)   
  end

  def unsho(tanka)
    shos.find_by(tanka_id: tanka.id).destroy
  end

  def sho?(tanka)
    sho_tankas.include?(tanka)
  end

  # allow users to update their accounts without passwords
  # http://easyramble.com/user-account-update-without-password-on-devise.html
  def update_without_current_password(params, *options)
    params.delete(:current_password)
 
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
 
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
  


end
