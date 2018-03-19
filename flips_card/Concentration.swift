//
//  concentation.swift
//  flips_card
//
//  Created by White on 2018/3/12.
//  Copyright © 2018年 White. All rights reserved.
//

import Foundation

class Concentration {
    //var cards = Array<Card>()
    var cards = [Card]();

    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil { foundIndex = index}
                    else { return nil }
                }
            }
            return foundIndex // 沒有被設定的話就回傳 optional 的 nil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index:Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                // indexOfOneAndOnlyFaceUpCard = nil
            }else {
                // 此處在 set 時，就已經完成了
                
//                for flipDownIndex in cards.indices {
//                    // 新的牌以外的牌，翻回去背面。
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                // 新的牌一樣翻成正面，以及只有單一張牌
//                cards[index].isFaceUp = true
                
                // 所以是唯一一張牌
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
//    func chooseCard(at index:Int){
//        if cards[index].isFaceUp{
//            cards[index].isFaceUp = false
//        }else {
//            cards[index].isFaceUp = true
//        }
//    }
    
    init(numberOfPairsCards: Int) {
        // 1...numberXXXXX  1 to 3
        for _ in 1...numberOfPairsCards
        {
            //let card = Card(identifier: identifier)
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the card.
        for _ in cards.indices {
            let randomIndex = cards.count.arc4random
            cards.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
    }

}
