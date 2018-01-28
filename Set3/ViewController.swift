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
        grid.frame = CGRect(x: 8, y: 8, width: 200, height: 250)
        grid.cellCount = 12
        
        tstGrid()
        
    }

    var grid = Grid(layout: Grid.Layout.aspectRatio(0.7) )
    
    func tstGrid() {
        let gridN = grid.cellCount
        let grid2 = grid[2]
        let dimension = grid.dimensions  // rowCount, column dount
        let cellSize = grid.cellSize
         print("cell count \(gridN) \n cell Rect  \(grid2) \n dimension \(dimension) \ncell Size \(cellSize)")
        
    }
    


}

