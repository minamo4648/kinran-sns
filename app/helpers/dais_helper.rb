module DaisHelper
    
    def judge_grade(dai)
        
        if dai.target_grade.present?
        
            if dai.target_grade.index(current_user.grade.to_s).nil?
            
                false
            
            else
            
                true
            
            end
        
        else
            
            true
        
        end
    
    end
    
    
    def judge_gender(dai)
    
        if dai.target_gender == 0 or dai.target_gender.nil?
        
            true
        
        else
        
            if dai.target_gender == current_user.gender
            
                true
            
            else
                
                false
            
            end
        
        end
        
    end
    
    def judge_target(dai)
        
        if current_user.admin
            
            true
            
        elsif dai.user_id == current_user.id
                    
            true
        
        elsif judge_gender(dai) and judge_grade(dai)
                    
            true
                
        else
                    
            false
                

        end
    
    
    end
    
end
