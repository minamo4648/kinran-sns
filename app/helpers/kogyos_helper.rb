module KogyosHelper
    
    def tsukeku_notice(num)
       
        if num.modulo(2) == 1
            note = "★　「五七五」で付句をします。\r\n"
        else
            note = "★　「七七」で付句をします。下七が４・３、２・５に分かれないようにします。\r\n"
        end       

        note = note + "★　俳句ではないので、「や」「かな」「けり」など、切れ字は用いません。\r\n"

        note = note + "★　「打越」と内容や句末の単語の品詞が重複しないようにします。\r\n"

        note = note + "★　花（＝桜）、月、恋が詠めるところは決まっているのでご留意下さい。\r\n"

        season = seasoning(Kogyo.last.season,num)
        
        if Kogyo.last.season == 3 and num == 2
            note = note + "★　発句が秋なので、ここで月を詠みます。\r\n"
        elsif Kogyo.last.season != 3 and num == 5
            note = note + "★　「月の定座」です。ここで月を詠みます。\r\n"
        elsif num == 17
            note = note + "★　「花の定座」です。ここで花（＝桜）を詠みます。\r\n"
        else
            if season == 0
                note = note + "★　季語は入れません。\r\n"
            else
                note = note + "★　#{["春","夏","秋","冬"][season - 1]}の季語を入れます。\r\n"
            end
        end
        
        case num
        when 8
            note = note + "★　恋の句を付けてもよいころです。恋の句か、それを予感させる内容にします。\r\n"
        when 9
            note = note + "★　恋の句を付けます。\r\n"
        when 10
            note = note + "★　恋の句を付けます。ここで恋の句は終わりなので、普通の内容に繋がりやすそうに付けます。\r\n"
        when 16
            note = note + "★　次が「花の定座」なので、植物を詠むのは避けます。\r\n" 
        when 18
            note = note + "★　挙句はそっと終わるような感じにします。\r\n"   
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
