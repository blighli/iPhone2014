//
//  DrawView.m
//  Notes
//
//  Created by xsdlr on 14/11/18.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "DrawView.h"
#import "PaintPath.h"

@interface DrawView()
@property (assign,nonatomic) CGMutablePathRef path;
@property (strong,nonatomic) NSMutableArray *pathArray;
@end

@implementation DrawView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _width = 15.0f;
        _color = [UIColor redColor];
        _path=CGPathCreateMutable();
        _pathArray = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context=UIGraphicsGetCurrentContext();
    for (PaintPath* path in _pathArray) {
        CGContextAddPath(context, path.path.CGPath);
        CGContextSetLineWidth(context, path.width);
        CGContextSetStrokeColorWithColor(context, [path.color CGColor]);
        CGContextSetLineCap(context, kCGLineCapRound);//圆形起笔
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    if (_path) {
        CGContextAddPath(context, _path);
        CGContextSetLineWidth(context, _width);
        CGContextSetStrokeColorWithColor(context, [_color CGColor]);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _path=CGPathCreateMutable();
    UITouch *touch=[touches anyObject];
    CGPoint location=[touch locationInView:self];
    CGPathMoveToPoint(_path, NULL, location.x, location.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch=[touches anyObject];
    CGPoint location=[touch locationInView:self];
    CGPathAddLineToPoint(_path, NULL, location.x, location.y);
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UIBezierPath* currentPath=[UIBezierPath bezierPathWithCGPath:_path];
    PaintPath* paintPath = [[PaintPath alloc] initWithColor:_color width:_width path:currentPath];
    [_pathArray addObject:paintPath];
    CGPathRelease(_path);
}

- (BOOL)clearView {
    [_pathArray removeAllObjects];
    [self setNeedsDisplay];
    return YES;
}

- (BOOL)saveToPNGFile:(NSString *)path {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
}
@end
