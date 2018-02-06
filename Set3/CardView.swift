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
    var path: UIBezierPath!
    
    
    var fill = false
    var radius: CGFloat {
        get {
            return bounds.height * 0.125
        }
    }// radius
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // **************** Drawing code **********************
       
       
        if card != nil {
            switch card.cardColor {
                case .red:    UIColor.red.setStroke()
                              UIColor.red.setFill()
                case .green:  UIColor.green.setStroke()
                              UIColor.green.setFill()
                case .blue:   UIColor.blue.setStroke()
                              UIColor.blue.setFill()
            }
            
            switch card.cardSymbol {
                case .circle : path = makeCirclePath()
                case .square : path = makeSquarePath()
                case .triangle: path = makeTrianglePath()
            }
            
            switch card.cardShade {
                case .blank:  break
                case .fill:   if path != nil { fill = true }
                case .light:  addStripPath()
                              path.addClip()
            }
  
        } // end if != nil
        
        if path != nil {
            path.stroke()
            if fill { path.fill()}
        } // path
    
      
    } // end draw()
    
    func makeCirclePath() -> UIBezierPath {
        var circlePath = UIBezierPath()
        
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        circlePath.addArc(withCenter: centerPoint ,
            radius: radius ,   // bounds.width
            startAngle: 0,
            endAngle: CGFloat.pi * 2,
            clockwise: true)
        return circlePath
    }
    
    var squareStart: CGPoint {
        get {
            return CGPoint(x: bounds.midX - radius,  y: bounds.midY - radius )
        }
    }
            
    
    
    func makeSquarePath() -> UIBezierPath {
        var squarePath = UIBezierPath()
        
        squarePath.move(to: squareStart)
        squarePath.addLine(to: CGPoint(x: squareStart.x + radius * 2.0, y: squareStart.y ))
        squarePath.addLine(to: CGPoint(x: squareStart.x + radius * 2.0, y: squareStart.y + radius * 2.0 ))
        squarePath.addLine(to: CGPoint(x: squareStart.x, y: squareStart.y + radius * 2.0 ))
        squarePath.close()
        return squarePath
    }
    
    func makeTrianglePath() -> UIBezierPath {
        var trianglePath = UIBezierPath()
        
        let triangleStart = CGPoint(x: bounds.midX, y: bounds.midY - radius )
        
        trianglePath.move(to: triangleStart)
        trianglePath.addLine(to: CGPoint(x: triangleStart.x + radius, y: squareStart.y + radius * 2.0 ))
        trianglePath.addLine(to: CGPoint(x: triangleStart.x - radius, y: squareStart.y + radius * 2.0 ))
        trianglePath.close()
        return trianglePath
    }
    
    let noStrips: CGFloat = 3.0 //  * 2
    
    func addStripPath() {
        var str = bounds.minY
        var space: CGFloat = radius / noStrips
        
        while str < bounds.maxY {
            path.move(to: CGPoint(x: bounds.minX, y: bounds.minY + space))
            path.addLine(to: CGPoint(x: self.bounds.maxX, y: bounds.minY + space)) // (x: circlePath.bounds.maxX, y: bounds.minY + space))
            //   circlePath.addClip()
            // circlePath.stroke()
            space += radius / noStrips
            str += radius / noStrips
        }
    } //  end addstrip()
    
} // EOF

/*
 func paintCard() {
 let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY )
 // test code
 circlePath.addArc(withCenter: centerPoint,
 radius: 20 ,   // bounds.width
 startAngle: 0,
 endAngle: CGFloat.pi * 2,
 clockwise: true)
 
 if path != nil {
 if fill {   path.fill() }
 path.stroke()
 }
 }
 //end test code
 */



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
