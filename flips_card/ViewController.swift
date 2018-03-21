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
    
    private(set) var flipCounter = 0
    {
        didSet
        {
            updateFlipCountLabel()
        }
    }
    @IBAction private func reStartGame(_ sender: UIButton)
    {
        initialSetup()
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth : 5.0 ,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips : \(flipCounter)", attributes: attributes)
        emojiLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var emojiLabel: UILabel!
    {
        didSet
        {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton)
    {
        if let cardNumber = cardButtons.index(of: sender)
        {
            if !game.cards[cardNumber].isMatched {
                flipCounter += 1
                if game.cards[cardNumber].isFaceUp {
                    game.chooseSameCard(at: cardNumber)
                    updateViewFromModel()
                }else {
                    game.chooseCard(at: cardNumber)
                    updateViewFromModel()
                }
            } else {
                updateViewFromModel()
            }

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
                if card.isMatched {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.5)
                    button.isEnabled = false
                }
            }else {
                button.isEnabled = true
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?
                    #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.5): #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                if button.backgroundColor == #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.5) {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.isEnabled = false
                }
            }
        }
    }
    
    //private var emojiChoices:Array<String> = ["🇹🇼","🇺🇸","🇬🇹","🇯🇵","🇬🇧","🇰🇷","🇦🇺","🇹🇭","🇲🇾","🇭🇰"]
    private var emojiChoices = "🇹🇼🇺🇸🇬🇹🇯🇵🇬🇧🇰🇷🇦🇺🇹🇭🇲🇾🇭🇰"
    
    private var emoji = [Card:String] ()
    
    private func emoji(for card: Card) -> String {
            if emojiChoices.count > 0, emoji[card] == nil{ // , == &&
                let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
                emoji[card] = String(emojiChoices.remove(at: stringIndex))
            }
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        }else {  
//            return "?"
//        }
        return  emoji[card] ?? "?"
    }
    
    
    // for init of the game.
    private func initialSetup() {
        // Create a new game.
        game = Concentration(numberOfPairsCards: (numberOfPairsOfCardsOnTable))
        updateViewFromModel()
        flipCounter = 0
        emojiChoices = "🇹🇼🇺🇸🇬🇹🇯🇵🇬🇧🇰🇷🇦🇺🇹🇭🇲🇾🇭🇰"
    }
}

extension Int {
    var arc4Random: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max..<0:
            return Int(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
    }
}

