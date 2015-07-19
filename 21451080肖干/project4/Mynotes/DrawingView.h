//
//  drawingView.h
//  Mynotes
//
//  Created by xiaoo_gan on 11/27/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    drawingToolTypePen,
    drawingToolTypeLine,
    drawingToolTypeRectagleStroke,
    drawingToolTypeRectagleFill,
    drawingToolTypeEllipseStroke,
    drawingToolTypeEllipseFill,
    drawingToolTypeEraser
} drawingToolType;

@protocol drawingViewDelegate, drawingTool;

@interface drawingView : UIView

@property (assign, nonatomic) drawingToolType drawTool;
@property (assign, nonatomic) id<drawingViewDelegate> delegate;

@property (assign, nonatomic) UIColor *lineColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) CGFloat lineAlpha;

@property (nonatomic,strong, readonly) UIImage *image;
@property (readonly, nonatomic) NSUInteger undoSteps;

- (void) loadImage:(UIImage *) image;
- (void) loadImageData:(NSData *) imageData;

- (void) clear;

- (BOOL) canUndo;
- (void) undoLatestStep;

- (BOOL) canRedo;
- (void) redoLatestStep;

@end

#pragma mark -

@protocol drawingViewDelegate <NSObject>

@optional
- (void) drawingView:(drawingView *)view willBeginDrawUsingTool:(id<drawingTool>) tool;
- (void) drawingView:(drawingView *)view didEndDrawUsingTool:(id<drawingTool>)tool;

@end