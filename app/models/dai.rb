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

  def genre_name

    ["短歌","俳句","川柳","都々逸","その他"][genre]
  
  end
  
  def top3_ids
    
    kins.group(:tanka_id).order('count_tanka_id desc').limit(3).count('tanka_id').keys
    
  end
  
  def vote_count
    
    tankas.each do |tanka|
      
      tanka.update(kin_cnt: tanka.kins.count)
      tanka.update(ran_cnt: tanka.rans.count)
      tanka.update(sho_cnt: tanka.shos.count)
      
      tanka.update(ransho_cnt: tanka.rans.count + tanka.shos.count)
    end
  
  end
  
  def fase_check!

    if self.due.present?  
      if self.fase == 1 and self.due < Time.zone.now
        
        self.fase = 2
        
          if self.all_select == false
            
                @notice = Notice.new
                @notice.body = "「#{self.title}」の投稿が締め切られ、撰歌に入りました"
                @notice.save
                @users = User.where('id in (?)', Tanka.where('dai_id = ?', self.id).pluck(:user_id))
                if @users.count > 0
                  @notice.note(@users)
                end
            
            self.selecting = true
          
          else
            binding.pry
                @notice = Notice.new
                @notice.body = "「#{self.title}」の投稿が締め切られました"
                @notice.link = "/dais/#{@dai.id}"
                @notice.save
                @users = User.where('id in (?)', Tanka.where('dai_id = ?', self.id).pluck(:user_id))
                if @users.count > 0
                  @notice.note(@users)
                end
                
          end
        
        self.save
      end
    end
    
    if self.v_due.present?  
      if self.fase == 2 and self.v_due < Time.zone.now
        
        self.fase = 3
        
                @notice = Notice.new
                @notice.body = "「#{self.title}」の投票が締め切られました"
                @notice.link = "/dais/#{@dai.id}"
                @notice.save
                @users = User.where('id in (?)', Tanka.where('dai_id = ?', self.id).pluck(:user_id))
                if @users.count > 0
                  @notice.note(@users)
                end
        
        self.save
      end
    end
  
  end

end