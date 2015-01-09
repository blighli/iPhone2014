//
//  RestartView.h
//  FlappyRect
//
//  Created by lg on 14-12-4.
//  Copyright (c) 2014年 lg. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class RestartView;
@protocol RestartViewDelegate <NSObject>

- (void)restartView:(RestartView *)restartView didPressRestartButton:(SKSpriteNode *)restartButton;

@end

@interface RestartView : SKSpriteNode

@property (weak, nonatomic) id <RestartViewDelegate> delegate;

+ (RestartView *)getInstanceWithSize:(CGSize)size;
- (void)dismiss;
- (void)showInScene:(SKScene *)scene;

@end
