//
//  quartzView.h
//  evernote
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface quartzView : UIView
- (void)addPA:(CGPoint)nPoint;
- (void)addLA;
- (void)clear;
-(void)setLineColor:(NSInteger)color;
-(void)setlineWidth:(NSInteger)width;
@end
