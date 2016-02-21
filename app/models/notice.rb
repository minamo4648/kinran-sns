class Notice < ActiveRecord::Base
    
  has_many :noteships, dependent: :destroy
  has_many :users, through: :noteships
  
    def note(users)

        if self.same_one.present?
            self.same_one.unnote(User.where('id in (?)', users.pluck(:id) & self.same_one.users.pluck(:user_id)))
        end
        users.each do |user|
        
            noteships.find_or_create_by(user_id: user.id)
        
        end

    end
    
    def same_one
    
        notices = Notice.where('id != ?', self.id).where(body: self.body).order(created_at: :desc)
        notices.first if notices
    end
    
    def unnote(users)
        
        users.each do |user|
        
            noteship = noteships.find_by(user_id: user.id)
            noteship.destroy if noteship
        
        end
    
    end
    
end
