//
//  DrawView.swift
//  TouchTracker
//
//  Created by 오민호 on 2017. 7. 7..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

struct Circle {
    private var point1 : CGPoint = CGPoint.zero
    private var point2 : CGPoint = CGPoint.zero
}

class DrawView : UIView {
    private var currentLines = [NSValue:Line]()
    private var finishedLines = [Line]()
    
    private var currentCircle = [NSValue : Circle]()
    private var finishedCircles = [Circle]()
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor : UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    func strokeCircle(circle: Circle) {
        let path = UIBezierPath()
        let center = CGPoint(x: (circle.point1.x + circle.point2.x) / 2,
                             y: (circle.point1.y + circle.point2.y) / 2)
        let dx = circle.point1.x - circle.point2.x
        let dy = circle.point1.y - circle.point2.y
        let radius = sqrt(dx*dx + dy*dy) / 2
        path.addArc(withCenter: center,
                    radius: radius,
                    startAngle: 0,
                    endAngle: 2.0 * CGFloat.pi,
                    clockwise: true)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        finishedLineColor.setStroke()
        for line in finishedLines {
             strokeLine(line: line)
        }
        
        for circle in finishedCircles {
            strokeCircle(circle: circle)
        }
    
        currentLineColor.setStroke()
        
        for (_, line) in currentLines {
            strokeLine(line: line)
        }
        
        for (_, circle) in currentCircle {
            strokeCircle(circle: circle)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        if touches.count == 2 {
            let touchOne = touches[touches.startIndex]
            let touchTwo = touches[touches.index(after: touches.startIndex)]
            let newCircle = Circle(point1: touchOne.location(in: self), point2: touchTwo.location(in: self))
            let key = NSValue(nonretainedObject: touchOne)
            currentCircle[key] = newCircle
            setNeedsDisplay()
            return
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        print(#function)
        if touches.count == 2 {
            let touchOne = touches[touches.startIndex]
            let touchTwo = touches[touches.index(after: touches.startIndex)]
            let key = NSValue(nonretainedObject: touchOne)
            currentCircle[key]?.point1 = touchOne.location(in: self)
            currentCircle[key]?.point2 = touchTwo.location(in: self)
            setNeedsDisplay()
            return
        }
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        if touches.count == 2 {
            let touchOne = touches[touches.startIndex]
            let touchTwo = touches[touches.index(after: touches.startIndex)]
            let key = NSValue(nonretainedObject: touchOne)
            if var circle = currentCircle[key] {
                circle.point1 = touchOne.location(in: self)
                circle.point2 = touchTwo.location(in: self)
                finishedCircles.append(circle)
                currentCircle.removeValue(forKey: key)
            }
            setNeedsDisplay()
            return
        }
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        currentLines.removeAll()
        setNeedsDisplay()
    }
}
