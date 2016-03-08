module KogyosHelper
    
    def tsukeku_notice(num)
       
        if num.modulo(2) == 1
            note = "★　「五七五」で付句をします。\r\n"
        else
            note = "★　「七七」で付句をします。\r\n"
        end       

        note = note + "★　俳句ではないので、「や」「かな」「けり」など、切れ字は用いません。\r\n"

        note = note + "★　「打越」と内容や、句末の単語の品詞が重複しないようにします。\r\n"

        season = seasoning(Kogyo.last.season,num)
        
        if season == 0
            note = note + "★　季語は入れません。\r\n"
        else
            note = note + "★　#{["春","夏","秋","冬"][season - 1]}の季語を入れます。\r\n"
        end
        
        return note

    end
    
    def seasoning(f_season, place)
    
        place = place - 1
    
        season = [[1,1,1,0,3,3,3,0,0,0,0,0,2,2,0,0,1,1],
                [2,2,0,0,3,3,3,0,0,0,0,0,4,4,0,0,1,1],
                [3,3,3,0,4,4,0,0,0,0,0,0,4,4,0,0,1,1],
                [4,4,0,0,3,3,3,0,0,0,0,0,2,2,0,0,1,1]]
    
        return season[f_season][place]
    
    end
    
end
