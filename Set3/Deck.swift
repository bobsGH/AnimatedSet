            //
            //  Deck.swift
            //  SET
            //
            //  Created by Bob Anderson on 1/6/18.
            //  Copyright © 2018 Bob Anderson. All rights reserved.
            //
            
import Foundation

struct Deck {
    var sorted = [Card]()
    var cardsInPlay = [Card]()
                
    mutating func makeDeck() {
        for symbol in Card.Symbol.all {
            for color in Card.FaceColor.all {
                for shade in Card.Shading.all {
                    for pip in Card.Pips.all {
                        let aCard = Card(cardSymbol: symbol, cardColor: color, cardShade: shade, cardPip: pip)
                        sorted.append(aCard)
                    } // end pip
                }// end shade
            } // end color
        } // end symbol
    }// end makeDeck()
    
    
    mutating func draw(_ n : Int) {
        if sorted.count >= n {
            for _ in 1...n {  // in 1
                let i =  Int(arc4random_uniform( UInt32(sorted.count)))
                let card = sorted[i]
                sorted.remove(at: i)
                cardsInPlay.append(card)
            }
        }
    }
  
    
    mutating func matched(index: [Int]) -> Bool {
        let sortedIndex = index.sorted()
        
        var symbolSet: Set<Card.Symbol> = []
        var colorSet: Set<Card.FaceColor> = []
        var shadeSet: Set<Card.Shading> = []
        var pipSet:    Set<Card.Pips> = []
        
        for i in index {
            symbolSet.insert(cardsInPlay[i].cardSymbol)
            colorSet.insert(cardsInPlay[i].cardColor)
            shadeSet.insert(cardsInPlay[i].cardShade)
            pipSet.insert(cardsInPlay[i].cardPip)
        }
        
        if shadeSet.ok && colorSet.ok && symbolSet.ok && pipSet.ok {
            for i in sortedIndex.sorted(by: >)  {
                cardsInPlay.remove(at: i) // if matched
            }
            if sorted.count > 2 { draw(3) }
            return true
        }
        return false // false
    }
    
    
}// EOF
            
            extension Set {
                var ok: Bool {
                    if self.count == 1 || self.count == 3 {
                        return true
                    } else {return false}  // false
                }
            }
            
            
            extension Int {
                var arc4random: Int {
                    if self > 0 {
                        return Int(arc4random_uniform(UInt32(self)))
                    } else if self < 0 {
                        return Int(arc4random_uniform(UInt32(-self))) // -Int
                    } else {
                        return 0  // return 0
                    }
                }
            }




