//
//  ViewController.swift
//  flips_card
//
//  Created by White on 2018/3/12.
//  Copyright © 2018年 White. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //var game = Concentration(numberOfPairsCards: 3)
    private lazy var game = Concentration(numberOfPairsCards: (numberOfPairsOfCardsOnTable))
    
    // Computed Probability
    private var numberOfPairsOfCardsOnTable:Int {
        get {
            return  ((cardButtons.count + 1) / 2)
        }
    }
    
    private(set) var flipCounter = 0 {
        didSet {
            emojiLabel.text = "Flips : \(flipCounter)"
        }
    }
    
    @IBOutlet private weak var emojiLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton)
    {
        flipCounter += 1
        
        if let cardNumber = cardButtons.index(of: sender)
        {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else
        {
            print("index error")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? self.view.backgroundColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices:Array<String> = ["🇹🇼","🇺🇸","🇬🇹","🇯🇵","🇬🇧","🇰🇷","🇦🇺","🇹🇭","🇲🇾","🇭🇰"]
    
    private var emoji = [Card:String] ()
    
    private func emoji(for card: Card) -> String {
            if emojiChoices.count > 0, emoji[card] == nil{ // , == &&
                emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            }
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        }else {  
//            return "?"
//        }
        return  emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

