class Dai < ActiveRecord::Base

  validates :title, length: { maximum: 15 }, presence: true
  validates :comment, length: { maximum: 2000 }, presence: true

  belongs_to :user
  
  has_many :tankas

  has_many :kins, class_name: "Kin", foreign_key: "dai_id", dependent: :destroy
  has_many :kin_users , through: :kins, source: :user
  has_many :kin_tankas , through: :kins, source: :tanka  
  
  has_many :rans, class_name: "Ran", foreign_key: "dai_id", dependent: :destroy
  has_many :ran_users , through: :rans, source: :user
  has_many :ran_tankas , through: :rans, source: :tanka

  has_many :shos, class_name: "Sho", foreign_key: "dai_id", dependent: :destroy
  has_many :sho_users , through: :shos, source: :user
  has_many :sho_tankas , through: :shos, source: :tanka
  
  def top3_ids
    
    kins.group(:tanka_id).order('count_tanka_id desc').limit(3).count('tanka_id').keys
    
  end
  
  def vote_count
    
    tankas.each do |tanka|
      
      tanka.kin_cnt = tanka.kins.count
      tanka.ran_cnt = tanka.rans.count
      tanka.sho_cnt = tanka.shos.count
      tanka.ransho_cnt = tanka.rans.count + tanka.shos.count
      
      tanka.save
      
    end
  
  end
  
  def fase_check!

    if self.due.present?  
      if self.fase == 1 and self.due < Time.now
        
        self.fase = 2
        
        self.save
      end
    end
    
    if self.v_due.present?  
      if self.fase == 2 and self.v_due < Time.now
        
        self.fase = 3
        
        self.save
      end
    end
  
  end

end