//
//  ZQuartzView.h
//  Note
//
//  Created by Mac on 14-11-23.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQuartzView : UIView 
@property (copy,nonatomic) NSMutableArray *paths;

@property (copy,nonatomic) NSMutableArray *points;

@property(copy,nonatomic) NSString *testParam;

@property (strong ,nonatomic) UIImageView *imageView;
@end
