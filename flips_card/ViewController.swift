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
    lazy var game = Concentration(numberOfPairsCards: (numberOfPairsOfCardsOnTable))
    
    // Computed Probability
    var numberOfPairsOfCardsOnTable:Int {
        get {
            return  ((cardButtons.count + 1) / 2)
        }
    }
    
    var flipCounter = 0 {
        didSet {
            emojiLabel.text = "Flips : \(flipCounter)"
        }
    }
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton)
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
    
    func updateViewFromModel() {
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
    
    var emojiChoices:Array<String> = ["🇹🇼","🇺🇸","🇬🇹","🇯🇵","🇬🇧","🇰🇷","🇦🇺","🇹🇭","🇲🇾","🇭🇰"]
    
    var emoji = [Int:String] ()
    
    func emoji(for card: Card) -> String {
            if emojiChoices.count > 0, emoji[card.identifier] == nil{ // , == &&
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        }else {
//            return "?"
//        }
        return  emoji[card.identifier] ?? "?"
    }
}

