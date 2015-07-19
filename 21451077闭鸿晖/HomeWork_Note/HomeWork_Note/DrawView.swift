
import UIKit


class DrawView:UIView {
    //路径定义
    struct PathDef {
        //贝塞尔曲线
        var path:UIBezierPath
        var color:CGColorRef
    }
    //标示当前是否在绘制一条path
    var isDrawing=false
    //路径数组
    var paths:[PathDef]!=[]
    //当前从beging到end绘制的一条path
    var curPath:CGMutablePathRef!
    
    var curColor:CGColorRef!
    var color:Int{
        set{
            switch newValue{
            case 0:curColor=UIColor.blackColor().CGColor
            case 1:curColor=UIColor.redColor().CGColor
            case 2:curColor=UIColor.greenColor().CGColor
            case 3:curColor=UIColor.blueColor().CGColor
            case 4:curColor=UIColor.purpleColor().CGColor
            default:break
            }
        }
        get{
            return 0
        }
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        func drawPath(#path:UIBezierPath,#color:CGColorRef){
            CGContextAddPath(context, path.CGPath)
            CGContextSetLineWidth(context, 1)
            CGContextSetStrokeColorWithColor(context,color)
            CGContextDrawPath(context, kCGPathStroke)
        }
        for myPath in paths{
            drawPath(path: myPath.path, color: myPath.color)
        }
        //当前正在drawing（touchesMoved阶段）
        if isDrawing{
            drawPath(path: UIBezierPath(CGPath: curPath), color: curColor)
        }
    
        
    }
    
    //MARK: - touchEvents
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        isDrawing=true
        var touch=touches.anyObject() as UITouch
        var point=touch.locationInView(self)
        //创建一个可变路径
        curPath=CGPathCreateMutable()
        //移动到起点
        CGPathMoveToPoint(curPath, nil, point.x, point.y)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) { var touch=touches.anyObject() as UITouch
        var point=touch.locationInView(self)
        //添加直线到当前路径
        CGPathAddLineToPoint(curPath, nil, point.x, point.y)
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var path:UIBezierPath=UIBezierPath(CGPath: curPath)
        paths.append(PathDef(path: path, color: curColor))
        isDrawing=false
    }
    
    
}
   