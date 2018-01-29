//
//  Card.swift
//  SET
//
//  Created by Bob Anderson on 1/6/18.
//  Copyright © 2018 Bob Anderson. All rights reserved.
//

import Foundation
import UIKit

struct Card  {
    
    var cardSymbol = Symbol.triangle
    var cardColor = FaceColor.red
    var cardShade = Shading.fill
    var cardPip = Pips.one

    enum Symbol {
        case triangle
        case square
        case circle
        
        static let all = [Symbol.triangle, .square, .circle]
    }
    
    enum FaceColor  {
        case red
        case green
        case blue
        
        static let all = [FaceColor.red, .green, .blue]
    }

    
    enum Shading {
        case fill
        case light
        case blank
        
        static let all = [Shading.fill, .light, .blank]
    }

    
    enum Pips  {
        case one
        case two
        case three
        
        static let all = [Pips.one, .two, .three]
    }

}
