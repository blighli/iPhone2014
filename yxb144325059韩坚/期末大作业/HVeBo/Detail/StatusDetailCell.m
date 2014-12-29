//
//  StatusDetailCell.m
//  HVeBo
//
//  Created by HJ on 14/12/16.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "StatusDetailCell.h"
#import "RetweetDetailDock.h"
#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "StatusDetailController.h"
#import "MainViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIView+Additions.h"

@interface StatusDetailCell()//<UIGestureRecognizerDelegate>
{
    RetweetDetailDock *_dock;
}
@end

@implementation StatusDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 1.操作条
        RetweetDetailDock *dock = [[RetweetDetailDock alloc] init];
        dock.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        CGFloat x = _retweeted.frame.size.width - dock.frame.size.width;
        CGFloat y = _retweeted.frame.size.height - dock.frame.size.height;
        dock.frame = CGRectMake(x, y, 0, 0);
        [_retweeted addSubview:dock];
        _dock = dock;
        
        // 2.监听被转发微博的点击
        //[_retweeted addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweetedDetail)]];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showRetweeted)];
//        tap.delegate = self;
//        [_retweeted addGestureRecognizer:tap];
    }
    return self;
}
////可能还有问题，待解决被转发微博链接只能长按
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([touch.view isKindOfClass:[_retweeted class]]) {
//        return YES;
//    }else{
//        return NO;
//    }
//}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[_retweeted class]] || [[touch.view nextResponder]isKindOfClass:[_retweeted class]])
    {
        StatusDetailController *detail = [[StatusDetailController alloc] init];
        detail.status = _dock.status;
        [self.viewController.navigationController pushViewController:detail animated:YES];
    }else{
//        StatusDetailController *detail = [[StatusDetailController alloc] init];
//        detail.status = _dock.status;
//        [self.viewController.navigationController pushViewController:detail animated:YES];
    }
}
//- (void)showRetweetedDetail
//{
//    if ([_delegate respondsToSelector:@selector(retweetStatus:)]) {
//            [_delegate retweetStatus:_dock.status];
//    }
//
//}

-(void)setStatusCellFrame:(BaseStatusCellFrame *)statusCellFrame
{
    [super setStatusCellFrame:statusCellFrame];
    
    // 设置子控件的数据
    _dock.status = statusCellFrame.status.retweetedStatus;
}

@end
