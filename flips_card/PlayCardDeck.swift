//
//  PlayCardDeck.swift
//  flips_card
//
//  Created by White on 2018/4/16.
//  Copyright © 2018年 White. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    private(set) var cards = [PlayingCard]()
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all{
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4Random)
        }else {
            return nil;
        }
    }
}

