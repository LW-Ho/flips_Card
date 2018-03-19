//
//  card.swift
//  flips_card
//
//  Created by White on 2018/3/12.
//  Copyright © 2018年 White. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false;
    var isMatched = false;
    var isCoosed = false;
    var identifier:Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
        // can remove Card struct.
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
