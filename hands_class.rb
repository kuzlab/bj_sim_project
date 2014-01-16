#--------------------------------------------
# All rights reserved by Yuichiro Kuzuryu
#--------------------------------------------

require("./bj_config.rb")

class Hands
    def initialize
        @cards = Array.new()
        @total = 0
        @face_card = 0
        @num_ace = 0
        @double_down_flag = 0
    end
    
    def getTotal
        return @total
    end
    
    def setTotal(value)
        @total = value
    end
    
    def getFaceCard
        return @face_card
    end
    
    def getNumOfAce
        return @num_ace
    end
    
    def setNumOfAce(value)
        @num_ace = value
    end
    
    def setDoubleDownFlag
        @double_down_flag = 1
    end
    
    def getDoubleDownFlag
        return @double_down_flag
    end
    
    
    def getCardNum
        return @cards.length()
    end
    
    def getCard(value)
        return @cards[value]
    end
    
    def addPulledCard(value)
        num = @cards.length()
        @cards[num] = value
        @total += value
        if value == 11
            @num_ace += 1
        end
        if num == 0
            @face_card = value
        end
    end    
        
    def setCard(num, value)
        @total -= @cards[num]
        if @cards[num] == 11
            @num_ace -= 1
        end
        @cards[num] = value
        @total += value
        if value == 11
            @num_ace += 1
        end
        if num == 0
            @face_card = value
        end
    end
    
    def getCard(num)
        return @cards[num]
    end
        
    def checkBJ
        if self.getCardNum == 2 && self.getTotal == 21
            return BLACK_JACK_YEAH
        else
            return NO_BLACK_JACK_BOO
        end
    end
        
    def splitDecision(dealer_face_card)
        result = 0
        if self.getCard(0) == self.getCard(1)
            if dealer_face_card <= SPLIT_THD
                result = 1
            end
        end
    end
    
    def doSplit(value)
        temp = @cards[1]
        @total -= temp
        if temp == 11
            @num_ace -= 1
        end
#        @cards[1] = nil
#        self.addPulledCard(value)
        @cards[1] = value
        @total += value
        if value == 11
            @num_ace += 1
        end
        return temp
    end

    def aceToOne
        if self.getNumOfAce > 0                
            total_temp = self.getTotal
            num_ace_temp = self.getNumOfAce
            self.setTotal(total_temp - 10)
            self.setNumOfAce(num_ace_temp - 1)
        else
            print("error --- aceToOne but getNumOfAce = 0")
        end
    end
    
    def doubleDownDecision(dealer_face_card)
        result = "NO_DOUBLE_DOWN"
        if dealer_face_card <= DD_DEALER_FACE_CARD_MAX && self.getTotal >= DD_MY_HANDS_TOTAL_MIN && self.getTotal <= DD_MY_HANDS_TOTAL_MAX
            result = DO_DOUBLE_DOWN
        end
        
        return result 
    end
    
    def compareOnlyFaceCard(dealer_face_card)
        temp = dealer_face_card + 10
        
        if temp > self.getTotal || self.getTotal > 21 #&& temp >= 17
            return DEALER_WIN_ONLY_FACE_CARD
        else
            return DEALER_NOT_WIN_ONLY_FACE_CARD
        end
    end
    
end
