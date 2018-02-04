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
    }
    
    var deck = Deck()
    
    @IBOutlet weak var score: UILabel!
    
  
    @IBAction func newGame(_ sender: UIButton) {
    }
    
    
    @IBAction func addCards(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var containerView: UIView!
    
    
    
    var grid = Grid(layout: Grid.Layout.aspectRatio(0.7) )
    
    func roundCornor(_ object: UIView) {
        object.layer.backgroundColor = UIColor.white.cgColor
        object.layer.borderWidth = 2.0
        object.layer.cornerRadius = 8.0
    }
    
    
    func paintCards() {
        grid.cellCount = deck.cardsInPlay.count
      //  for i in 0..<grid.cellCount  {
        for i in 0..<deck.cardsInPlay.count {
            var cardView = CardView()
            if let cardRect = grid[i]{
                cardView.frame = cardRect
                roundCornor(cardView)
                containerView.addSubview(cardView)
                cardView.backgroundColor = UIColor.white
              //  cardView.pipColor = deck.cardsInPlay[i].cardColor.rawValue
                cardView.card = deck.cardsInPlay[i]
            }

        }
       // print("subViews \(containerView.subviews[1])")   //
        containerView.subviews[1].layer.borderColor = UIColor.green.cgColor
        print(" card in play count \(deck.cardsInPlay.count), card \(deck.cardsInPlay[1])")
        
        
        
        
    } // end paintCards()

}// EOF

/*
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

