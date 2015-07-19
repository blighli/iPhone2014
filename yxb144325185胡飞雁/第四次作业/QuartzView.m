
#import "QuartzView.h"
#import "UIColor+Random.h"

@implementation QuartzView

- (CGRect)currentRect
{
    return CGRectMake(_firstTouch.x, _firstTouch.y, _lastTouch.x-_firstTouch.x, _lastTouch.y-_firstTouch.y);
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        _currentColor=[UIColor redColor];
        _useRandomColor=NO;
        _drawImage=[UIImage imageNamed:@"christinna.jpg"];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_useRandomColor) {
        self.currentColor=[UIColor randomColor];
    }
    UITouch *touch=[touches anyObject];
    _firstTouch=[touch locationInView:self];
    _lastTouch=[touch locationInView:self];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    _lastTouch=[touch locationInView:self];
    
    if (_shapeType==kImageShape) {
        CGFloat horizontalOffset=_drawImage.size.width/2;
        CGFloat verticaloffset=_drawImage.size.height/2;
        _redrawrRect=CGRectUnion(_redrawrRect, CGRectMake(_lastTouch.x-horizontalOffset, _lastTouch.y-verticaloffset, _drawImage.size.width, _drawImage.size.height));
    }
    else
    {
        _redrawrRect=CGRectUnion(_redrawrRect, self.currentRect);
    }
    _redrawrRect=CGRectInset(_redrawrRect, -2.0, -2.0);
    
    [self setNeedsDisplayInRect:_redrawrRect];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    _lastTouch=[touch locationInView:self];
    
    if (_shapeType==kImageShape) {
        CGFloat horizontalOffset=_drawImage.size.width/2;
        CGFloat verticaloffset=_drawImage.size.height/2;
        _redrawrRect=CGRectUnion(_redrawrRect, CGRectMake(_lastTouch.x-horizontalOffset, _lastTouch.y-verticaloffset, _drawImage.size.width, _drawImage.size.height));
    }
    else
    {
        _redrawrRect=CGRectUnion(_redrawrRect, self.currentRect);
    }
    _redrawrRect=CGRectInset(_redrawrRect, -2.0, -2.0);
    
    [self setNeedsDisplayInRect:_redrawrRect];
    float x1=_firstTouch.x;
    float y1=_firstTouch.y;
    float x2=_lastTouch.x;
    float y2=_lastTouch.y;
    int shap=_shapeType;
    NSArray *array=@[[NSNumber numberWithInt:shap],[NSNumber numberWithFloat:x1],[NSNumber numberWithFloat:y1],[NSNumber numberWithFloat:x2],[NSNumber numberWithFloat:y2]];
    [_shapeArray addObject:array];
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef contex=UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(contex, 2.0);
    CGContextSetStrokeColorWithColor(contex, _currentColor.CGColor);
    
    CGContextSetFillColorWithColor(contex, _currentColor.CGColor);
  
    if ([_shapeArray count]==0)
        return;
    for(id shape in _shapeArray)
    {
        NSNumber *sh=shape[0];
        NSNumber *x1=shape[1];
        NSNumber *y1=shape[2];
        NSNumber *x2=shape[3];
        NSNumber *y2=shape[4];
        CGRect rct=CGRectMake([x1 floatValue], [y1 floatValue], [x2 floatValue]-[x1 floatValue], [y2 floatValue]-[y1 floatValue]);
        switch ([sh intValue]) {
            case kLineShape:
                CGContextMoveToPoint(contex, [x1 floatValue], [y1 floatValue]);
                CGContextAddLineToPoint(contex, [x2 floatValue], [y2 floatValue]);
                CGContextStrokePath(contex);
                break;
            case kRectShape:
                CGContextAddRect(contex, rct);
                CGContextDrawPath(contex, kCGPathFillStroke);
                break;
            case kEllipseShape:
                CGContextAddEllipseInRect(contex, rct);
                CGContextDrawPath(contex, kCGPathFillStroke);
                break;
            case kImageShape:
            {
                CGFloat horizontalOffset=_drawImage.size.width/2;
                CGFloat verticalOffset=_drawImage.size.height/2;
                CGPoint drawPoint=CGPointMake(_lastTouch.x-horizontalOffset, _lastTouch.y-verticalOffset);
                [_drawImage drawAtPoint:drawPoint];
                break;
            }
                
            default:
                break;
        }
    }
    
}
@end
