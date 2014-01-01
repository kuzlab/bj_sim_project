#--------------------------------------------
# All rights reserved by Yuichiro Kuzuryu
#--------------------------------------------

require("./hands_class")

class AllHands
    
    def initialize
        @dealer_hands = Hands.new()
        @first_hands = Hands.new()
        @second_hands = Hands.new()
        @third_hands = Hands.new()
        @ext1_hands = Hands.new()
        @ext2_hands = Hands.new()
        @ext3_hands = Hands.new()
        
        @doubleDownFlag = Array.new(7)
        @splitFlag = Array.new(7)
        @blackJackFlag = Array.new(4)        
    end
    
    def getTotal(num)
        case num
        when 0
            return @dealer_hands.getTotal
        when 1 
            return @first_hands.getTotal
        when 2
            return @second_hands.getTotal
        when 3
            return @third_hands.getTotal
        when 4
            return @ext1_hands.getTotal
        when 5
            return @ext2_hands.getTotal
        when 6
            return @ext3_hands.getTotal
        else
            print("error - getTotal(num) wrong num\n")
        end
    end
    
    def setTotal(num, value)
        case num
        when 0
            @dealer_hands.setTotal
        when 1 
            @first_hands.setTotal
        when 2
            @second_hands.setTotal
        when 3
            @third_hands.setTotal
        when 4
            @ext1_hands.setTotal
        when 5
            @ext2_hands.setTotal
        when 6
            @ext3_hands.setTotal
        else
            print("error - setTotal(num, value) wrong num\n")
        end
    end
    
    def addPulledCard(num, value)
        case num
        when 0
            @dealer_hands.addPulledCard(value)
        when 1 
            @first_hands.addPulledCard(value)
        when 2
            @second_hands.addPulledCard(value)
        when 3
            @third_hands.addPulledCard(value)
        when 4
            @ext1_hands.addPulledCard(value)
        when 5
            @ext2_hands.addPulledCard(value)
        when 6
            @ext3_hands.addPulledCard(value)
        else
            print("error - addPulledCard(num, value) wrong num\n")
        end
    end
    
    def getFaceCard(num)
        case num
        when DEALER
            return @dealer_hands.getFaceCard
        when FIRST 
            return @first_hands.getFaceCard
        when SECOND
            return @second_hands.getFaceCard
        when THIRD
            return @third_hands.getFaceCard
        when EXT1
            return @ext1_hands.getFaceCard
        when EXT2
            return @ext2_hands.getFaceCard
        when EXT3
            return @ext3_hands.getFaceCard
        else
            print("error - getFaceCard(num) wrong num\n")
        end
    end
    
    def checkBJ(num)
        case num
        when DEALER
            return @dealer_hands.checkBJ
        when FIRST 
            return @first_hands.checkBJ
        when SECOND
            return @second_hands.checkBJ
        when THIRD
            return @third_hands.checkBJ
        else
            print("error - checkBJ(num) wrong num\n")
        end
    end
        
    def getNumOfAce(num)
        case num
        when DEALER
            return @dealer_hands.getNumOfAce
        when FIRST 
            return @first_hands.getNumOfAce
        when SECOND
            return @second_hands.getNumOfAce
        when THIRD
            return @third_hands.getNumOfAce
        when EXT1
            return @ext1_hands.getNumOfAce
        when EXT2
            return @ext2_hands.getNumOfAce
        when EXT3
            return @ext3_hands.getNumOfAce
        else
            print("error - getNumOfAce(num) wrong num\n")
        end
    end
    
    def aceToOne(num)
        case num
        when DEALER
            @dealer_hands.aceToOne
        when FIRST 
            @first_hands.aceToOne
        when SECOND
            @second_hands.aceToOne
        when THIRD
            @third_hands.aceToOne
        when EXT1
            @ext1_hands.aceToOne
        when EXT2
            @ext2_hands.aceToOne
        when EXT3
            @ext3_hands.aceToOne
        else
            print("error - aceToOne(num) wrong num\n")
        end
    end
     
    def getCardNum(num)
        case num
        when DEALER
            return @dealer_hands.getCardNum
        when FIRST 
            return @first_hands.getCardNum
        when SECOND
            return @second_hands.getCardNum
        when THIRD
            return @third_hands.getCardNum
        when EXT1
            return @ext1_hands.getCardNum
        when EXT2
            return @ext2_hands.getCardNum
        when EXT3
            return @ext3_hands.getCardNum
        else
            print("error - getCardNum(num) wrong num\n")
        end
    end
    
    def setDoubleDownFlag(num)
        @doubleDownFlag[num] = 1
    end
    
    def getDoubleDownFlag(num)
        return @doubleDownFlag[num]
    end
    
    def setSplitFlag(num)
        @splitFlag[num] = 1
    end
    
    def getSplitFlag(num)
        return @splitFlag[num]
    end
    
    def getCard(num1, num2)
        case num1
        when DEALER
            return @dealer_hands.getCard(num2)
        when FIRST 
            return @first_hands.getCard(num2)
        when SECOND
            return @second_hands.getCard(num2)
        when THIRD
            return @third_hands.getCard(num2)
        when EXT1
            return @ext1_hands.getCard(num2)
        when EXT2
            return @ext2_hands.getCard(num2)
        when EXT3
            return @ext3_hands.getCard(num2)
        else
            print("error - getCard(num1, num2) wrong num1\n")
        end
    end
    
    def setBlackJackFlag(num)
        @blackJackFlag[num] = 1
    end
    
    def getBlackJackFlag(num)
        return @blackJackFlag[num]
    end
    
    def splitDecision(num)
        case num
        when FIRST
            return @first_hands.splitDecision(@dealer_hands.getFaceCard)
        when SECOND
            return @second_hands.splitDecision(@dealer_hands.getFaceCard)
        when THIRD
            return @third_hands.splitDecision(@dealer_hands.getFaceCard)
        else
            print("error - splitDecision(num) wrong num\n")
        end
    end
    
    def doSplit(num, value1, value2)
        case num
        when FIRST
            @ext1_hands.addPulledCard(@first_hands.doSplit(value1))
            @ext1_hands.addPulledCard(value2)
            @splitFlag[1] = 1
            @splitFlag[4] = 1
        when SECOND
            @ext2_hands.addPulledCard(@second_hands.doSplit(value1))
            @ext2_hands.addPulledCard(value2)            
            @splitFlag[2] = 1
            @splitFlag[5] = 1
        when THIRD
            @ext3_hands.addPulledCard(@third_hands.doSplit(value1))
            @ext3_hands.addPulledCard(value2)            
            @splitFlag[3] = 1
            @splitFlag[6] = 1
        else
            print("error - splitDecision(num, value1, value2) wrong num\n")
        end        
    end
    
    def standDecision(num, dealer_face_card)
        result = 0
        case num
        when FIRST
            if @first_hands.getCardNum <= 0 || (@first_hands.getCard(0) == 11 && @splitFlag[num] == 1) || @blackJackFlag[num] == 1 
                 return DECIDE_STAND
            else
                temp = @first_hands.getTotal
            end
        when SECOND
            if @second_hands.getCardNum <= 0 || (@second_hands.getCard(0) == 11 && @splitFlag[num] == 1) || @blackJackFlag[num] == 1
                 return DECIDE_STAND
            else
                temp = @second_hands.getTotal
            end
        when THIRD
            if @third_hands.getCardNum <= 0 || (@third_hands.getCard(0) == 11 && @splitFlag[num] == 1) || @blackJackFlag[num] == 1
                 return DECIDE_STAND
            else
                temp = @third_hands.getTotal
            end
        when EXT1
            if @ext1_hands.getCardNum <= 0 || (@ext1_hands.getCard(0) == 11 && @splitFlag[num] == 1)
                 return DECIDE_STAND
            else
                temp = @ext1_hands.getTotal
            end
        when EXT2
            if @ext2_hands.getCardNum <= 0 || (@ext2_hands.getCard(0) == 11 && @splitFlag[num] == 1)
                 return DECIDE_STAND
            else
                temp = @ext2_hands.getTotal
            end
        when EXT3
            if @ext3_hands.getCardNum <= 0 || (@ext3_hands.getCard(0) == 11 && @splitFlag[num] == 1)
                 return DECIDE_STAND
            else
                temp = @ext3_hands.getTotal
            end
        else
            print("error - standDecision(num, dealer_face_card) wrong num\n")
        end
        
        if dealer_face_card > DEALER_FACE_CARD_WEAK_STRONG_THD
            if temp > HIT_MAX_WEAK_DEALER            
                result = DECIDE_STAND
            end
        else
            if temp > HIT_MAX_STRONG_DEALER            
                result = DECIDE_STAND
            end
        end
        
        return result
    end
    
    def doubleDownDecision(num)
        case num
        when FIRST
            if @first_hands.doubleDownDecision(@dealer_hands.getFaceCard) == DO_DOUBLE_DOWN
                @doubleDownFlag[num] = 1
            end
        when SECOND
            if @second_hands.doubleDownDecision(@dealer_hands.getFaceCard) == DO_DOUBLE_DOWN
                @doubleDownFlag[num] = 1
            end
        when THIRD
            if @third_hands.doubleDownDecision(@dealer_hands.getFaceCard) == DO_DOUBLE_DOWN
                @doubleDownFlag[num] = 1
            end
        when EXT1
            if @ext1_hands.doubleDownDecision(@dealer_hands.getFaceCard) == DO_DOUBLE_DOWN
                @doubleDownFlag[num] = 1
            end
        when EXT2
            if @ext2_hands.doubleDownDecision(@dealer_hands.getFaceCard) == DO_DOUBLE_DOWN
                @doubleDownFlag[num] = 1
            end
        when EXT3
            if @ext3_hands.doubleDownDecision(@dealer_hands.getFaceCard) == DO_DOUBLE_DOWN
                @doubleDownFlag[num] = 1
            end
        else
            print("error - doubleDownDecision(num) wrong num\n")
        end 
    end
    
    def getDoubleDownFlag(num)
        return @doubleDownFlag[num]
    end
    
end
    
    