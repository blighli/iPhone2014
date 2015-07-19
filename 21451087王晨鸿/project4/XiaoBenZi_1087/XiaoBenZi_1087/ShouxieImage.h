//
//  ShouxieImage.h
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-23.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <UIKit/UIKit.h>
static BOOL allline=NO;

@interface ShouxieImage : UIView
{
    NSMutableArray* myallpoint;
    NSMutableArray* myallline;
}
-(void)Introductionpoint1;
-(void)Introductionpoint2;
-(void)Introductionpoint3:(CGPoint)sender;
-(void)Introductionpoint4:(int)sender;
-(void)Introductionpoint5:(int)sender;

//=====================================
-(void)myalllineclear;
-(void)myLineFinallyRemove;
+(void)cleanAllLine;
@end
