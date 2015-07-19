//
//  drawingTools.h
//  Mynotes
//
//  Created by xiaoo_gan on 11/27/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __has_feature(objc_arc)
#define HAS_ARC 1
#define RETAIN(exp) (exp)
#define RELEASE(exp)
#define AUTORELEASE(exp) (exp)
#else
#define HAS_ARC 0
#define RETAIN(exp) [(exp) retain]
#define RELEASE(exp) [(exp) release]
#define AUTORELEASE(exp) [(exp) autorelease]
#endif

@protocol drawingTool <NSObject>

@property (strong, nonatomic) UIColor *lineColor;
@property (assign, nonatomic) CGFloat lineAlpha;
@property (assign, nonatomic) CGFloat lineWidth;

- (void)setInitialPoint:(CGPoint)firstPoint;
- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint;
- (void)draw;

@end

#pragma mark -

@interface drawingPenTool : UIBezierPath<drawingTool> {
    CGMutablePathRef path;
}
-(CGRect) addPathPreviousPreviousPoint:(CGPoint)p2Point withPreviousPoint:(CGPoint)p1Point withCurrentPoint:(CGPoint)cpoint;
@end

#pragma mark -

@interface drawingEraserTool : drawingPenTool

@end

#pragma mark -

@interface drawingLineTool : NSObject<drawingTool>

@end

#pragma mark -

@interface drawingRectangleTool : NSObject<drawingTool>

@property (assign, nonatomic) BOOL fill;

@end

#pragma mark -

@interface drawingEllipseTool : NSObject<drawingTool>
@property (assign, nonatomic) BOOL fill;
@end
