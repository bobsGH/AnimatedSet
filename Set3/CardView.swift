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
        
        let topTransform = CGAffineTransform(translationX: 0.0, y: bounds.height * topOffset )
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
                    path.addClip()
                    stripPath.stroke()
                    path.stroke()
                } // end if stripPath
            }// end switch on pip
        } // end if card != nil
    } // end draw()
    
    
    func makeCirclePath() -> UIBezierPath {
        let circlePath = UIBezierPath()
        
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
        let squarePath = UIBezierPath()
        
        squarePath.move(to: squareStart)
        squarePath.addLine(to: CGPoint(x: squareStart.x + radius * 2.0, y: squareStart.y ))
        squarePath.addLine(to: CGPoint(x: squareStart.x + radius * 2.0, y: squareStart.y + radius * 2.0 ))
        squarePath.addLine(to: CGPoint(x: squareStart.x, y: squareStart.y + radius * 2.0 ))
        squarePath.close()
        return squarePath
    }
    
    func makeTrianglePath() -> UIBezierPath {
        let trianglePath = UIBezierPath()
        
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
        let stripPath = UIBezierPath()
        
        while y < bounds.maxY {  
            stripPath.move(to: CGPoint(x: bounds.minX, y: y ))
            stripPath.addLine(to: CGPoint(x: self.bounds.maxX, y: y))
            y += space
        }
        return stripPath
    } //  end addstripPath()
    
} // EOF


