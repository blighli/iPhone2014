//
//  Paint.h
//  paint
//
//  Created by hanxue on 14/11/15.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#ifndef paint_Paint_h
#define paint_Paint_h


#endif
#import <UIKit/UIKit.h>

@interface paintview : UIView
{
    NSMutableArray *paints;
    NSMutableArray *lines;
    NSMutableArray *Startpoint;
    CGPoint Curpoint;
    NSMutableArray *Endpoint;
    BOOL isFirst;
    CGContextRef context;
}
@property (nonatomic,retain) UIColor* paintcolor;
@property (nonatomic,strong) UIImage* imagenow;
-(void) clear: (BOOL) flag;
-(void) save:(BOOL) flag;
@end