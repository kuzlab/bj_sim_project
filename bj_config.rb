#--------------------------------------------
# All rights reserved by Yuichiro Kuzuryu
#--------------------------------------------

=begin
ブラックジャックシミュレーションの定数の定義を記述する
=end

BJ_CONFIG = 1


DECK = 3 # 使用するトランプのデッキ数
SHUFFLE = 0.3 * DECK * 4 * 13 # 何枚まで使ったらシャッフルするか
PLAYERS = 3 # プレイヤーの人数
INITIAL_FUND = 100 # 初期の資金$
BET_UNIT = 1 # $

TOTAL_MATCH = 1000

DEALER_BLACK_JACK = "DealerBJ"

INS_TYPE_RANDOM = "RANDOM"
INS_TYPE_HANDS_TOTAL = "HANDS_TOTAL"
INS_TYPE_HANDS_TOTAL_THD = 18 # 手札がこれ以上だったらインシュランス

INSURANCE_TYPE = INS_TYPE_HANDS_TOTAL

SPLIT_THD = 6


DEALER = 0
FIRST = 1
SECOND = 2
THIRD = 3
EXT1 = 4
EXT2 = 5
EXT3 = 6

NAME = ["dealer", "1st", "2nd", "3rd", "Ext1", "Ext2", "Ext3"]

DD_DEALER_FACE_CARD_MAX = 6
DD_MY_HANDS_TOTAL_MIN = 0
DD_MY_HANDS_TOTAL_MAX = 11

HIT_MAX_WEAK_DEALER = 16
HIT_MAX_STRONG_DEALER = 16
DEALER_FACE_CARD_WEAK_STRONG_THD = 7

DO_DOUBLE_DOWN = "DO_DOUBLE_DOWN"

BLACK_JACK_YEAH = "BALCK_JACK_YEAH"
NO_BLACK_JACK_BOO = "NO_BALCK_JACK_BOO"

DECIDE_STAND = "DECIDE_STAND"