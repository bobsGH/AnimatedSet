//
//  CardView.swift
//  Set3
//
//  Created by Bob Anderson on 1/28/18.
//  Copyright © 2018 Bob Anderson. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var card: Card!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // **************** Drawing code **********************
        let bounds = self.bounds
        
         let circlePath = UIBezierPath()
        
        if card != nil {
            switch card.cardColor {
                case .red : print( "red")
                case .green:  UIColor.green.setStroke()                   //print("green")
                case .blue: print("blue")
            }
            
            // test code
            var centerPoint = CGPoint(x: bounds.midX, y: bounds.midY )
            circlePath.addArc(withCenter: centerPoint,
                              radius: 10 ,   // bounds.width
                startAngle: 0,
                endAngle: CGFloat.pi * 2,
                clockwise: true)
            circlePath.stroke()
            //end test code 
  
        } // end if != nil

    
    }
    
 

}

/*
 let circlePath = UIBezierPath()
 var centerPoint = CGPoint(x: bounds.midX, y: bounds.midY )
 circlePath.addArc(withCenter: centerPoint,
 radius: 10 ,   // bounds.width
 startAngle: 0,
 endAngle: CGFloat.pi * 2,
 clockwise: true)
 circlePath.stroke()
 
 print("pipColor \(card.cardColor)\n")
 
 */
