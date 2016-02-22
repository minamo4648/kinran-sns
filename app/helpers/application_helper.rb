module ApplicationHelper
    
    def six_year_array
        
        @this_year = (Date.today - 91).year

        [*(@this_year - 1966 ..@this_year + 5 - 1966)]
        
    end
    
    def gen(user)
        
        case user.gender
        when 1
            return "男"
        when 2
            return "女"
        else
            return nil
        end
        
    end
    
    def shorten(str, num)

        if str.length >= num
    
            str[0,num] + "..."
    
        else
    
            str
    
        end
    
    end
    
end
