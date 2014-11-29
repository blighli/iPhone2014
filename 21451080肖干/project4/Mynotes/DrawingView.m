//
//  drawingView.m
//  Mynotes
//
//  Created by xiaoo_gan on 11/27/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "DrawingView.h"
#import "DrawingTools.h"

#import <QuartzCore/QuartzCore.h>

#define kDefaultLineColor   [UIColor blackColor]
#define kDefaultLineWidth   7.0f
#define kDefaultLineAlpha   1.0f

#define PARRTIAL_REDRAW     0

@interface drawingView ()
{
    CGPoint currentPoint;
    CGPoint previousPoint1;
    CGPoint previousPoint2;
}

@property (strong, nonatomic) NSMutableArray *pathArray;
@property (strong, nonatomic) NSMutableArray *bufferArray;
@property (strong, nonatomic) id<drawingTool> currentTool;
@property (strong, nonatomic) UIImage *image;

@end

#pragma mark -
@implementation drawingView

- (id) initWithFrame:(CGRect)frame
{
    //self = [super initWithFrame:<#frame#>];
    
    if (self) {
        [self configure];
    }
    return self;
}
- (void) configure
{
    self.pathArray = [NSMutableArray array];
    self.bufferArray = [NSMutableArray array];
    
    self.lineColor = kDefaultLineColor;
    self.lineWidth = kDefaultLineWidth;
    self.lineAlpha = kDefaultLineAlpha;
    self.backgroundColor = [UIColor clearColor];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
#if PARTIAL_REDRAW
    [self drawPath];
#else
    [self.image drawInRect:self.bounds];
    [self.currentTool draw];
#endif
}

- (void) updateCacheImage:(BOOL) redraw
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    if (redraw) {
        self.image = nil;
        for (id<drawingTool>tool in self.pathArray) {
            [tool draw];
        }
    } else {
        [self.image drawAtPoint:CGPointZero];
        [self.currentTool draw];
    }
    
    //保存手绘图片
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (id<drawingTool>) toolWithCurrentSettings
{
    switch (self.drawTool) {
        case drawingToolTypePen:
        {
            return AUTORELEASE([drawingPenTool new]);
        }
        case drawingToolTypeLine:
        {
            return AUTORELEASE([drawingLineTool new]);
        }
        case drawingToolTypeRectagleStroke:
        {
            drawingRectangleTool *tool = AUTORELEASE([drawingRectangleTool new]);
            tool.fill = NO;
            return tool;
        }
        case drawingToolTypeRectagleFill:
        {
            drawingRectangleTool *tool = AUTORELEASE([drawingRectangleTool new]);
            tool.fill = YES;
            return tool;
        }
        case drawingToolTypeEllipseStroke:
        {
            drawingEllipseTool *tool = AUTORELEASE([drawingEllipseTool new]);
            tool.fill = NO;
            return tool;
        }
        case drawingToolTypeEllipseFill:
        {
            drawingEllipseTool *tool = AUTORELEASE([drawingEllipseTool new]);
            tool.fill = YES;
            return tool;
        }
        case drawingToolTypeEraser:
        {
            return AUTORELEASE([drawingEraserTool new]);
        }
    }
}

#pragma mark - Touch Methods
//开始触摸
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.currentTool = [self toolWithCurrentSettings];
    self.currentTool.lineWidth = self.lineWidth;
    self.currentTool.lineColor = self.lineColor;
    self.currentTool.lineAlpha = self.lineAlpha;
    [self.pathArray addObject:self.self.currentTool];
    
    //添加第一次触摸
    UITouch *touch = [touches anyObject];
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    [self.currentTool setInitialPoint:currentPoint];
    
    //调用delegate
    if ([self.delegate respondsToSelector:@selector(drawingView:willBeginDrawUsingTool:)]) {
        [self.delegate drawingView:self willBeginDrawUsingTool:self.currentTool];
    }
}
//触摸移动
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //保存触摸移动路径上的所有点
    UITouch *touch = [touches anyObject];
    previousPoint2 = previousPoint1;
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    if ([self.currentTool isKindOfClass:[drawingPenTool class]]) {
        CGRect bounds = [(drawingPenTool *) self.currentTool addPathPreviousPreviousPoint:previousPoint2 withPreviousPoint:previousPoint1 withCurrentPoint:currentPoint];
        CGRect drawBox = bounds;
        drawBox.origin.x -= self.lineWidth * 2.0;
        drawBox.origin.y -= self.lineWidth * 2.0;
        drawBox.size.width += self.lineWidth * 4.0;
        drawBox.size.height += self.lineWidth * 4.0;
        [self setNeedsDisplayInRect:drawBox];
    } else {
        [self.currentTool moveFromPoint:previousPoint1 toPoint:currentPoint];
        [self setNeedsDisplay];
    }
}
//最后触摸点
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //保存最后触摸点
    [self touchesMoved:touches withEvent:event];
    //更新image
    [self updateCacheImage:NO];
    //清除redo队列
    [self.bufferArray removeAllObjects];
    // 调用delegate
    if ([self.delegate respondsToSelector:@selector(drawingView:didEndDrawUsingTool:)]) {
        [self.delegate drawingView:self didEndDrawUsingTool:self.currentTool];
    }
    //清除当前工具
    self.currentTool = nil;
}
//最后触摸点不在画布上
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //保存在画布上的最后触摸点
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - Load Image
//加载图片
- (void) loadImage:(UIImage *)image
{
    self.image = image;
    //如果加载的是外部图片，清除所有缓存
    [self.bufferArray removeAllObjects];
    [self.pathArray removeAllObjects];
    [self updateCacheImage:NO];
    [self setNeedsDisplay];
}

- (void) loadImageData:(NSData *)imageData
{
    CGFloat imageScale;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        imageScale = [[UIScreen mainScreen] scale];
    } else {
        imageScale = 1.0;
    }
    UIImage *image = [UIImage imageWithData:imageData scale:imageScale];
    [self loadImage:image];
}

#pragma mark - Action

- (void) clear
{
    [self.bufferArray removeAllObjects];
    [self.pathArray removeAllObjects];
    [self updateCacheImage:YES];
    [self setNeedsDisplay];
}

#pragma mark - Undo / Redo

- (NSUInteger) undoSteps
{
    return self.bufferArray.count;
}
- (BOOL) canUndo
{
    return self.pathArray.count > 0;
}

//撤消上次操作
- (void) undoLatestStep
{
    if ([self canUndo]) {
        id<drawingTool> tool = [self.pathArray lastObject];
        [self.bufferArray addObject:tool];
        [self.pathArray removeLastObject];
        [self updateCacheImage:YES];
        [self setNeedsDisplay];
    }
}
//是否可以redo
- (BOOL) canRedo
{
    return self.bufferArray.count > 0;
}

- (void) redoLatestStep
{
    if ([self canRedo]) {
        id<drawingTool> tool = [self.bufferArray lastObject];
        [self.pathArray addObject:tool];
        [self.bufferArray removeLastObject];
        [self updateCacheImage:YES];
        [self setNeedsDisplay];
    }
}

#if !HAS_ARC

- (void)dealloc
{
    self.pathArray = nil;
    self.bufferArray = nil;
    self.currentTool = nil;
    self.image = nil;
    [super dealloc];
}

#endif

@end
