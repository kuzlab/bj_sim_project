#autoload("bj_config.rb")
require("./bj_config.rb")
require("./hands_class.rb")
require("./allhands_class.rb")

class Bj
    
    def initialize()
        @fund = INITIAL_FUND
#        @parent = [0, 0, 0] # 親の手持ちカードの合計、Aの枚数、 フェイスカード
#        @hands = Array.new(PLAYERS * 3)

#        for i in 0..(PLAYERS * 3)
#            @hands[i] = 0
#        end        
        
        @match_count = 0
        
        @win_num = 0
        @lose_num = 0
        @draw_num = 0
        
        @win_dd_num = 0
        @lose_dd_num = 0
        @draw_dd_num = 0
        
        @win_split_num = 0
        @lose_split_num = 0
        @draw_split_num = 0
        
        @black_jack = 0
        
        @burst_count = 0
        
        @ins_win = 0
        @ins_lose = 0
        
        @even_money = 0
        
        
        @cards = Array.new(DECK * 4 * 13)
        
        @cards_pulled = 0

        for i in 0..(DECK * 4 * 13)
            @cards[i] = 1
        end
    end
    
    def addWin(num)
        @win_num += 1
        @fund += BET_UNIT
        if @hands.getBlackJackFlag(num) == 1
            @black_jack += 1
            @fund += BET_UNIT * 0.5           
        else
            if @hands.getDoubleDownFlag(num) == 1
                @win_dd_num += 1
                @fund += BET_UNIT
            end
            if @hands.getSplitFlag(num) == 1
                @win_split_num += 1
            end        
        end
    end
    
    def addLose(num)
        @lose_num += 1
        @fund -= BET_UNIT
        if @hands.getDoubleDownFlag(num) == 1
            @lose_dd_num += 1
            @fund -= BET_UNIT
        end
        if @hands.getSplitFlag(num) == 1
            @lose_split_num += 1
        end
        if @hands.getTotal(num) > 21
            @burst_count += 1
        end
    end
    
    def addDraw(num)
        @draw_num += 1
        if @hands.getDoubleDownFlag(num) == 1
            @draw_dd_num += 1
        end
        if @hands.getSplitFlag(num) == 1
            @draw_split_num += 1
        end
    end
    
    def getWinNum
        return @win_num
    end

    def getLoseNum
        return @lose_num
    end
    
    def getDrawNum
        return @draw_num
    end
    
    def getEndMatch
        return TOTAL_MATCH
    end
    
    def getMatchCount
        return @match_count
    end
    
    def addMatchCount
        @match_count += 1
    end    
    
    def getFund
        return @fund
    end
    
    def dispResults
        print("match count: #{@match_count}\n")
        print("fund: #{@fund}\n")
        print("w/l/d = #{@win_num}/ #{@lose_num}/ #{@draw_num}\n")
        print("d.d. w/l/d = #{@win_dd_num}/ #{@lose_dd_num}/ #{@draw_dd_num}\n")
        print("split w/l/d = #{@win_split_num}/ #{@lose_split_num}/ #{@draw_split_num}\n")
        print("BlackJack = #{@black_jack}, Burst = #{@burst_count}\n")
        print("Ins. w/l/even m. = #{@ins_win}/ #{@ins_lose}/ #{@even_money}\n")
    end
    
    def getPullCardValue        
        while @cards[temp = rand(DECK * 4 * 13)] != 1
        end
        @cards[temp] = 0
        temp = temp%13
        if temp > 10 || temp == 0
            temp = 10
        end
        if temp == 1
            temp = 11
        end
        
        @cards_pulled += 1
        
        return temp
    end


    def deal
        @hands = AllHands.new()
        
        for j in 0..1
            for i in DEALER..THIRD
                @hands.addPulledCard(i, self.getPullCardValue) 
            end
        end
    end
    
    def dispAllHands
        
        for j in DEALER..EXT3
            num = @hands.getCardNum(j)
            print("#{NAME[j]} : (")
            if num > 0
                for i in 0..(num - 1)
                    print("#{@hands.getCard(j, i)},")
                end
                print(") -> total = #{@hands.getTotal(j)}")
                print(" (Ace = #{@hands.getNumOfAce(j)})")
                if @hands.getDoubleDownFlag(j) == 1
                    print("*DD*")
                end
                if @hands.getBlackJackFlag(j) == 1
                    print("*BJ*")
                end
                if @hands.getSplitFlag(j) == 1
                    print("*SPLIT*")
                end
                if @hands.getTotal(j) > 21
                    print("*BURST*")
                end      
            else
                print(" -- no cards")
            end
            print("\n")
        end
    end
    
    def insuranceIfDealerAce
        result = "none"
        ins_count = 0
        even_money_count = 0
        if @hands.getFaceCard(DEALER) == 11
            if INSURANCE_TYPE == INS_TYPE_HANDS_TOTAL
                for i in FIRST..THIRD
                    if @hands.getTotal(i) >= INS_TYPE_HANDS_TOTAL_THD
                        ins_count += 1
                        if @hands.getTotal(i) == 21
                            even_money_count += 1
                        end
                    end 
                end
            end
            
            if @hands.getTotal(DEALER) == 21
                for i in 0..(ins_count -1)
                    @ins_win += 1
                    @even_money += even_money_count
                    @fund += BET_UNIT * even_money_count
                end
                for i in 0..(PLAYERS - ins_count -1)                
                    self.addLose(i)
                end
                result = DEALER_BLACK_JACK
            else
                @fund -= ins_count * BET_UNIT * 0.5
                for i in 0..(ins_count -1)
                    @ins_lose += 1
                end
            end
        end
        
        
        return result
    end
    
    def hitStandRoutines
        for i in FIRST..THIRD
            while @hands.getTotal(i) > 21 && @hands.getNumOfAce(i) > 0
                @hands.aceToOne(i)
            end
        end
        for i in FIRST..THIRD
            if @hands.checkBJ(i) == BLACK_JACK_YEAH
                @hands.setBlackJackFlag(i)
            else
                if @hands.splitDecision(i) == 1
                    @hands.doSplit(i, self.getPullCardValue, self.getPullCardValue)
                end
            end
        end
        
        for i in FIRST..EXT3
            while @hands.getTotal(i) > 21 && @hands.getNumOfAce(i) > 0
                @hands.aceToOne(i)
            end
        end
        for i in FIRST..EXT3
            if @hands.standDecision(i, @hands.getFaceCard(DEALER)) != DECIDE_STAND
                @hands.doubleDownDecision(i)
                while @hands.standDecision(i, @hands.getFaceCard(DEALER)) != DECIDE_STAND
                    @hands.addPulledCard(i, self.getPullCardValue)
                    while @hands.getTotal(i) > 21 && @hands.getNumOfAce(i) > 0
                        @hands.aceToOne(i)
                    end
                    if @hands.getDoubleDownFlag(i) == 1
                        break
                    end
                end
            end
        end
        
                
        while @hands.getTotal(DEALER) < 17
            @hands.addPulledCard(DEALER, self.getPullCardValue)
            if @hands.getTotal(DEALER) > 21 && @hands.getNumOfAce(DEALER) > 0
                @hands.aceToOne(DEALER)
            end
        end
    end
    
    def calResults
        lose_flag = Array.new(6)
        # Burst check
        for i in FIRST..EXT3
            if @hands.getTotal(i) > 21 && @hands.getCardNum(i) > 0
                self.addLose(i)
                lose_flag[i] = 1
            end
        end        
        
        if @hands.getTotal(DEALER) > 21
            for i in FIRST..EXT3
                if lose_flag[i] != 1 && @hands.getCardNum(i) > 0
                    self.addWin(i)
                    lose_flag[i] = 0
                end
            end
        else
            for i in FIRST..EXT3
                if lose_flag[i] != 1 && @hands.getCardNum(i) > 0
                    if @hands.getTotal(i) > @hands.getTotal(DEALER)
                        self.addWin(i)
                    else
                        if @hands.getTotal(i) == @hands.getTotal(DEALER)
                            self.addDraw(i)
                        else
                            self.addLose(i)
                        end
                    end
                end
            end                                                 
        end            
        
    end
    
    
    def shuffleIfNeed
       if @cards_pulled > SHUFFLE
           print("--- Card Shuffle ---\n")
           for i in 0..(DECK * 4 * 13)
               @cards[i] = 1
           end
           @cards_pulled = 0 
       end
    end
    
                
end

