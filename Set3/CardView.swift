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
    var strip = false
    
    var radius: CGFloat {
        get {
            return bounds.height * 0.125
        }
    }// radius
    let topOffset: CGFloat =  -0.3
    let bottomOffset: CGFloat =  0.3
   
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // **************** Drawing code **********************
        
        
       
        var topTransform = CGAffineTransform(translationX: 0.0, y: bounds.height * topOffset )
        let bottomTransform = CGAffineTransform(translationX: 0.0, y: bounds.height * bottomOffset * 2 )
       
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
                case .light:  addStripPath() //strip = true
                
            }
            
            switch card.cardPip {
                case .one:  path.stroke()
                            if fill { path.fill()}
                
                
                case .two:  path.apply(topTransform)
                
                            if fill { path.fill()}
                         //   if strip {addStrip()}
                            path.stroke()
                
                            path.apply(bottomTransform)
                            if fill { path.fill()}
                          //  if strip {addStrip(); print("two") }
                            path.stroke()
                
            case .three:  path.stroke()
                          if fill { path.fill()}
                          //if strip {addStrip()}
            
                          path.apply(topTransform)
                          path.stroke()
                          if fill { path.fill()}
                      //    if strip {addStrip()}
            
                          path.apply(bottomTransform)
                          path.stroke()
                          if fill { path.fill()}
                      //    if strip {addStrip();  print("three")}
                
            
            }// end switch
            
  
        } // end if card != nil
        
        
      
    } // end draw()
    
//    func addStrip() {
//        if strip {
//           // print("strip")
//            addStripPath()
//            path.addClip()
//           // path.stroke()
//
//        }
   //}
    
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
    
    let noStrips: CGFloat = 3.0 //  will twice this many strips
    
    func addStripPath() {
        var str = bounds.minY
        var space: CGFloat = radius / noStrips
        
        
        while space < bounds.maxY {  // was str
            path.move(to: CGPoint(x: bounds.minX, y: bounds.minY + space))
            path.addLine(to: CGPoint(x: self.bounds.maxX, y: bounds.minY + space)) 
            space += radius / noStrips
           // str += radius / noStrips
        }
    } //  end addstripPath()
    
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
