//
//  ViewController.swift
//  Set3
//
//  Created by Bob Anderson on 1/27/18.
//  Copyright © 2018 Bob Anderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        deck.makeDeck()
        deck.draw(12)
      //  grid.frame = containerView.bounds
      //  paintCards()
        score = 0
        
        
        
    } // viewDidLoad
  

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        grid.frame = containerView.safeAreaLayoutGuide.layoutFrame
        paintCards()
    }

    var deck = Deck()
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }

  
    @IBAction func newGame(_ sender: UIButton) {
        deck.sorted.removeAll()
        deck.cardsInPlay.removeAll()
        score = 0
        deck.makeDeck()
        deck.draw(12)
        paintCards()
    }
    
    
    @IBAction func addCards(_ sender: UIButton) {
        deck.draw(3)
        paintCards()
    }
    
    var tapReconizer: UITapGestureRecognizer!
    
    @IBOutlet weak var containerView: UIView!
    

    var grid = Grid(layout: Grid.Layout.aspectRatio(0.7) )  // 0.7
    
    func roundCornor(_ object: UIView) {
        object.layer.backgroundColor = UIColor.white.cgColor
        object.layer.borderWidth = 2.0
        object.layer.cornerRadius = 8.0
    }
    
    var selected: [Int] = []
    
    @objc func selectCard(recongizer: UITapGestureRecognizer){
        switch recongizer.state {
            case.ended:
                if let cardTag = recongizer.view?.tag { // deselect
                    if selected.contains(cardTag){
                    containerView.subviews[cardTag].layer.borderColor = UIColor.black.cgColor
                    } else if selected.count < 3  { // select a card
                        selected.append(cardTag)
                        containerView.subviews[cardTag].layer.borderColor = UIColor.orange.cgColor
                    } else { // check selection
                        for card in selected {
                               containerView.subviews[card].layer.borderColor = UIColor.black.cgColor
                        }
                        if deck.matched(index: selected) {
                            score += 1
                        }
                        selected.removeAll()
                        paintCards()
                    }
                }// end if cardtag
            
            default: break
        }// end switch
    } // end sellectedCard()
    
    
    func paintCards() {
       
      let subViews = containerView.subviews
        for sub in subViews {
            sub.removeFromSuperview()
        }
        
        grid.cellCount = deck.cardsInPlay.count
        
        for i in 0..<deck.cardsInPlay.count {
            
            tapReconizer = UITapGestureRecognizer(target: self, action: #selector(selectCard(recongizer: )) ) // each cardView
            var  cardView = CardView()
            cardView = CardView()
            if let cardRect = grid[i]{
                cardView.frame = cardRect
                roundCornor(cardView)
                cardView.backgroundColor = UIColor.white
                
                cardView.card = deck.cardsInPlay[i]
                
                cardView.addGestureRecognizer(tapReconizer)
                containerView.addSubview(cardView)
                cardView.tag = i
            } // end if
        } // end for
    } // end paintCards()

}// EOF

