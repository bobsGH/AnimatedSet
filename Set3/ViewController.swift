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
        grid.frame = containerView.bounds
        paintCards()
        score = 0
    } // viewDidLoad
    
    
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
    
    @IBOutlet weak var containerView: UIView! // {

    var grid = Grid(layout: Grid.Layout.aspectRatio(0.7) )
    
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

/*
 
 //        didSet {
 //
 // //           tapReconizer = UITapGestureRecognizer(target: self, action: #selector(selectCard(recongizer: )) )
 //
 //       //     containerView.addGestureRecognizer(tapReconizer)  // works ----------
 //
 //        } // end didset
 //    } // end containerView
 //
 
 containerView.subviews[3].addGestureRecognizer(tapReconizer)
 containerView.subviews[0].addGestureRecognizer(tapReconizer)
 
 // print(" card in play count \(deck.cardsInPlay.count), card \(deck.cardsInPlay[1])")
 // view.setNeedsDisplay()
 
 //  containerView.didAddSubview(<#T##subview: UIView##UIView#>)
 
 
        // print("subViews \(containerView.subviews[1])")   //
 
 //  cardView.addGestureRecognizer(tapReconizer)  //
 // containerView.subviews[i].addGestureRecognizer(tapReconizer)
 //  cardView.tapRec = self.tapReconizer
              //  containerView.subviews[i].addGestureRecognizer(tapReconizer)
 
 //  cardView.addGestureRecognizer(tapReconizer)
 //      containerView.subviews[i].addGestureRecognizer(tapReconizer)
 
 // test
 // let tapReconizer = UITapGestureRecognizer(target: self, action: #selector(selectCard) )
 //let tapReconizer = UIGestureRecognizer(target: self, action: #selector(selectCard) )
 
 // test
 func tap(){
 print("cardview taped")
 }
 
 print("subview.count \( containerView.subviews.count)")
 for cv in containerView.subviews {
 print("tag \(cv.tag)")
 }
 //            cv.isUserInteractionEnabled = true
 //            cv.addGestureRecognizer(tapReconizer)
 
 
 func tstGrid() {
 let gridN = grid.cellCount
 let grid2 = grid[2]
 let dimension = grid.dimensions  // rowCount, column dount
 let cellSize = grid.cellSize
 print("grid.cellCount \(gridN) \n grid2  \(grid2) \n grid.dimension \(dimension) \n grid.cellSize \(cellSize)")
 
 var containerSize = containerView.frame
 //print("container size \(containerSize)")
 
 // print("grid2 \(grid2)")
 
 let cardSubView = CardView()
 var cardRect = CGRect(x: 108.0, y: 0.0, width: 50.0, height: 71.4)
 //roundCornor(cardSubView)
 
 cardSubView.frame = cardRect
 cardSubView.backgroundColor = .yellow
 
 roundCornor(score)
 
 // self.view = view
 // view.addSubview(cardSubView)
 containerView.addSubview(cardSubView)
 }
 
 
 */

