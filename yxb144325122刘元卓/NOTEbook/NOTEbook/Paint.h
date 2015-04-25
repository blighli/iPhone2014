//
//  Paint.h
//  NOTEbook
//
//  Created by SXD on 14/12/3.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

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
-(UIImage *) screenShot;
@end
