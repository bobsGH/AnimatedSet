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
       // grid.frame = CGRect(x: 8, y: 8, width: 200, height: 250)
       // grid.frame = containerView.frame
        grid.frame = containerView.bounds
        print("containerView.frame \(containerView.frame)")
        grid.cellCount = 12
    
        
       // tstGrid()
        paintCards()
        
    }
    
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
 
    
    func paintCards() {
        
        for i in 0..<grid.cellCount  {
            var cardView = CardView()
          
            var cardRect = grid[i]
         
            cardView.frame = cardRect!
            cardView.backgroundColor = .green
            roundCornor(cardView)
            //cardView = cardRect
           // print("cardView frame \(cardView.frame)\n cardView \(cardView)\n")
          
            
            containerView.addSubview(cardView)
            
        }
    }

}

