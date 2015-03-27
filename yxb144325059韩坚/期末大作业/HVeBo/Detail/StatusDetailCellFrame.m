//
//  StatusDetailFrame.m
//  HVeBo
//
//  Created by HJ on 14/12/15.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "StatusDetailCellFrame.h"
#import "Status.h"

@implementation StatusDetailCellFrame

-(void)setStatus:(Status *)status
{
    [super setStatus:status];
    if (status.retweetedStatus) {
        _retweetedFrame.size.height += kDetailDockHeight;
        _cellHeight += kDetailDockHeight;
    }
}

@end
