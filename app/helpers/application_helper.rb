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

        if str.length > num
    
            str[0,num] + "..."
    
        else
    
            str
    
        end
    
    end

    def i_to_kan(num)

        x = ""

        kansuuji = ["","一","二","三","四","五","六","七","八","九"]
        
        if num > 1 and num < 100
            if num >= 10
                if num >= 20
                    x = kansuuji[num.div(10)]  + "十"
                else
                    x = "十"
                end
            end
            x = x + kansuuji[num.modulo(10)]
        end        

        return x        
        
    end
    
    def heisei(y)
    
        return y - 1988
    
    end
    
    def wareki(mydate)
    
        x = "平成" + i_to_kan(heisei(mydate.year)) + "年" + i_to_kan(mydate.month) + "月" + i_to_kan(mydate.day) + "日"
        
        return x
    
    end
    
    def kogyo_fase
    
        if Kogyo.count == 0
            return 1
        elsif Kogyo.last.place >= 2 and Kogyo.last.place <= 18
        
            if Kogyo.last.next_due < Time.zone.now and Kogyo.last.pick_type != 1
                if Kogyo.last.pick_type == 0 and Kogyo.last.voting == true
                    Kogyo.last.update(next_due: Kogyo.last.next_due + 1.day)
                else
                    if Kogyo.last.pick_type == 2 and Kogyo.last.voting == true and Kogyo.last.rengas.where(place: Kogyo.last.place).count > 0
                        advance_kogyo
                    elsif Kogyo.last.voting == false and Kogyo.last.rengas.where(place: Kogyo.last.place).count > 0
                        Kogyo.last.update(voting: true)
                    end
                    Kogyo.last.update(next_due: Kogyo.last.next_due + Kogyo.last.thinking_hour.hour)
                end
            end
            
            return 2
        else
            return 1
        end
    
    end
    
    def place_name(num)
    
        x = ["","発句","脇　","三　","四　","月　","折端","折立","二　","三　","四　","五　","六　","七　","八　","九　","十　","花　","挙句"][num]
    
        return x
    
    end
    
    def advance_kogyo
    
        @kogyo = Kogyo.last
        @rengas = Renga.where(kogyo_id: @kogyo.id, place: @kogyo.place)
        @vote_result = RengaVotership.joins(:renga).where(rengas: {place: @kogyo.place}).where(rengas: {kogyo_id: @kogyo.id}).group(:renga_id).order('count_renga_id desc').count('renga_id')
        @top_vote_number = @vote_result.values.first
        @top_ids = Array.new
        
        @vote_result.keys.each do |r_id|
            if @vote_result[r_id] == @top_vote_number
                @top_ids << r_id
            end
        end
    
        @top_renga = Renga.where('id in (?)', @top_ids).order(updated_at: :asc).first
        
        @top_renga.update(picked: true)
        @kogyo.update(place: @kogyo.place + 1)
    
        if @kogyo.pick_type == 0    
            @kogyo.update(next_due: Time.zone.now + @kogyo.thinking_hour.hour)
        end
    
        @kogyo.update(voting: false)
    
    end
    
end
