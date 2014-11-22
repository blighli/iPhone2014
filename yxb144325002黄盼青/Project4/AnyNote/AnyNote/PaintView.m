//
//  PaintView.m
//  paintDemo
//
//  Created by 黄盼青 on 14/11/17.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "PaintView.h"

@interface PaintView()

@property (assign,nonatomic) CGMutablePathRef path;
@property (assign,nonatomic) BOOL isHavePath;
@property (strong,nonatomic) NSMutableArray *pathArray;

@end

@implementation PaintView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
//        self.backgroundColor=[UIColor grayColor];
        //初始化线宽和颜色
        _lineWidth=3.0f;
        _lineColor=[UIColor blackColor];
        _path=CGPathCreateMutable();
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [self drawView:context];
}

-(void)drawView:(CGContextRef)context{
    
    //遍历旧的路径
    for(PainterLineModel *models in _pathArray){
        CGContextAddPath(context, models.linePath.CGPath);
        CGContextSetLineWidth(context, models.lineWidth);
        CGContextSetStrokeColorWithColor(context, [models.lineColor CGColor]);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    //判断是否有新路径
    if(_isHavePath)
    {
    CGContextAddPath(context, _path);
    CGContextSetLineWidth(context, _lineWidth);
    CGContextSetStrokeColorWithColor(context, [_lineColor CGColor]);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextDrawPath(context, kCGPathStroke);
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _path=CGPathCreateMutable();
    UITouch *touch=[touches anyObject];
    CGPoint location=[touch locationInView:self];
    CGPathMoveToPoint(_path, NULL, location.x, location.y);
    _isHavePath=YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint location=[touch locationInView:self];
    CGPathAddLineToPoint(_path, NULL, location.x, location.y);
    
    [self setNeedsDisplay];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //获取当前绘制的曲线
    UIBezierPath *_oldPath=[UIBezierPath bezierPathWithCGPath:_path];
    PainterLineModel *_model=[[PainterLineModel alloc]initWithPainterInfo:_lineWidth withColor:_lineColor withPath:_oldPath];
    
    if(!_pathArray){
        //初始化路径数组
        _pathArray=[NSMutableArray array];
    }
    
    //写入数组
    [_pathArray addObject:_model];
    
    _isHavePath=NO;
    
    CGPathRelease(_path);
}

//清空视图
-(void)clearView{
    [_pathArray removeAllObjects];
    [self setNeedsDisplay];
}

//保存图片
-(UIImage *)saveToImage{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    return image;
}

@end
