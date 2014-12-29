//
//  LeftTableViewCell.m
//  HVeBo
//
//  Created by HJ on 14/12/22.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundView.frame = CGRectMake(0, 0, 180, 44);
    self.selectedBackgroundView.frame = CGRectMake(0, 0, 180, 44);
    //self.textLabel.textAlignment = NSTextAlignmentCenter;
}

@end
