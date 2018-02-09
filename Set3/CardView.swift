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
    var stripPath: UIBezierPath!
    
    
  
    
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
                case .light:  stripPath = addStripPath() //strip = true
                
            }
            
            switch card.cardPip {
                case .one:  path.stroke()
                            if fill { path.fill()}
                            if stripPath != nil {
                                path.addClip()
                                stripPath.stroke()
                            }
                
            case .two:   path.apply(topTransform)
                         path.stroke()
                         if fill { path.fill()}
            
                        let save = path.cgPath
                        path.apply(bottomTransform)
                        path.stroke()
            
                        if fill { path.fill()}
                        if stripPath != nil {
                               let new = UIBezierPath(cgPath: save)
                               path.append(new)
                          //  print("two striped ")
                                path.addClip()
                                stripPath.stroke()
                                path.stroke()
                        }
                

                
                case .three:  path.stroke()
                                if fill { path.fill()}
                                let middle = path.cgPath
                
                                path.apply(topTransform)
                                let top = path.cgPath
                                path.stroke()
                                if fill { path.fill()}
                
                                path.apply(bottomTransform)
                                path.stroke()
                                if fill { path.fill()}
                
                                if stripPath != nil {
                                    let newTop = UIBezierPath(cgPath: top)
                                    path.append(newTop)
                                    let newMiddle = UIBezierPath(cgPath: middle)
                                    path.append(newMiddle)
                            //print("three striped ")
                                    path.addClip()
                                    stripPath.stroke()
                                    path.stroke()
                                } // end if stripPath
            
                
            
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
    
    func addStripPath() -> UIBezierPath {
        var y = bounds.minY
        let space: CGFloat = radius / noStrips
        var stripPath = UIBezierPath()
        
        while y < bounds.maxY {  // was str
            stripPath.move(to: CGPoint(x: bounds.minX, y: y ))
            stripPath.addLine(to: CGPoint(x: self.bounds.maxX, y: y))
            //space += radius / noStrips
            y += space
        }
        return stripPath
    } //  end addstripPath()
    
} // EOF


//var top = path!
// var bottom = path!

// path.apply(topTransform)
// top.stroke()
//  bottom.apply(bottomTransform)
//bottom.stroke()
//  top.append(bottom)
//    top.stroke()
//                            path.removeAllPoints()
//                            path = top
//                            path.append(bottom!)
//                            path.stroke()
//                            if fill { path.fill()}

// path.apply(topTransform)
//  path.stroke()
// if fill { path.fill()}
// if stripPath != nil {
//  path.addClip()
//  stripPath.stroke()
// }


//copy?.apply(bottomTransform)
//path.append(copy!)
// path.stroke()



//                            if stripPath != nil {
//                                path.addClip()
//                                stripPath.stroke()
//                            }

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
