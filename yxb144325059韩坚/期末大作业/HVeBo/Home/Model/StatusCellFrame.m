//
//  StatusCellFrame.m
//  HVeBo
//
//  Created by HJ on 14/12/9.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "StatusCellFrame.h"

@implementation StatusCellFrame

- (void)setStatus:(Status *)status
{
    [super setStatus:status];
    
    //_cellHeight += kStatusDockHeight -2;
    
    _cellHeight = 34 + _cellHeight;
}

@end
