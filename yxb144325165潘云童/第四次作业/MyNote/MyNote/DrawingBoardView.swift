//
//  DrawingBoardView.swift
//  MyNote
//
//  Created by Joker on 14/11/21.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

import UIKit

class DrawingBoardView: UIView {
    
    var path = CGPathCreateMutable()
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        var point = touches.anyObject()?.locationInView(self) as CGPoint!
        CGPathMoveToPoint(path, nil, point.x, point.y)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        var point = touches.anyObject()?.locationInView(self) as CGPoint!
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        setNeedsDisplay()
    }

    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, path)
        CGContextStrokePath(context)
    }
}
