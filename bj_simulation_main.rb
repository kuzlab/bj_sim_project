#--------------------------------------------
# All rights reserved by Yuichiro Kuzuryu
#--------------------------------------------

=begin
ここにメインループを記述
=end

load("./bj_class.rb")

bjsim = Bj.new()

while bjsim.getMatchCount < bjsim.getEndMatch

    bjsim.deal
    
    split_flag = 0
    split_facecard = 0
    
    if bjsim.insuranceIfDealerAce != DEALER_BLACK_JACK
        bjsim.hitStandRoutines
        
        bjsim.calResults
    end
    
    bjsim.dispAllHands
    bjsim.dispHandsHistgram
    
    
    bjsim.shuffleIfNeed

    bjsim.dispResults()
    bjsim.addMatchCount  
end







