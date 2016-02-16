module ApplicationHelper
    
    def six_year_array
        
        @this_year = (Date.today - 91).year

        [*(@this_year - 1966 ..@this_year + 5 - 1966)]
        
    end
    
end
