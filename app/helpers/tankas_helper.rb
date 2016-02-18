module TankasHelper
    
    def listtanka_ok?(tanka)
    
        if tanka.user == current_user then
            
            true
        
        elsif tanka.dai.fase == 3 and tanka.exposed == true then
        
            true
            
        else    
        
            false
        
        end
    
    end
    
end
