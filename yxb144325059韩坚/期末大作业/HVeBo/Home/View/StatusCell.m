//
//  StatusCell.m
//  HVeBo
//
//  Created by HJ on 14/12/9.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "StatusDock.h"
#import "MDHTMLLabel.h"
#import "UIView+Additions.h"
#import "StatusDetailController.h"
#import "Status.h"

@interface StatusCell()//<UIGestureRecognizerDelegate>
{
    StatusDock *_dock;
}
@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //7.Dock
        CGFloat y = self.frame.size.height - 34;
        _dock = [[StatusDock alloc]initWithFrame:CGRectMake(0, y, 0, 0)];
        //[_retweeted addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweeted)]];
        //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showRetweeted)];
        //tap.delegate = self;
        //[_retweeted addGestureRecognizer:tap];
        [self.contentView addSubview:_dock];
    }
    return self;
}
//可能还有问题，待解决被转发微博链接只能长按
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
////    NSLog(@"%@",touch.view);
////    if ([touch.view isKindOfClass:[UIImageView class]]) {
////        return YES;
////    }else{
////        return NO;
////    }
//    return NO;
//}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[_retweeted class]] || [[touch.view nextResponder]isKindOfClass:[_retweeted class]])
    {
        StatusDetailController *detail = [[StatusDetailController alloc] init];
        detail.status = _dock.status.retweetedStatus;
        [self.viewController.navigationController pushViewController:detail animated:YES];
    }else{
        StatusDetailController *detail = [[StatusDetailController alloc] init];
        detail.status = _dock.status;
        [self.viewController.navigationController pushViewController:detail animated:YES];
    }
}
- (void)setStatusCellFrame:(BaseStatusCellFrame *)statusCellFrame
{
    [super setStatusCellFrame:statusCellFrame];
    //0.dcok
    _dock.status = statusCellFrame.status;
//    CGRect fram = _dock.frame;
//    fram.origin.y = statusCellFrame.cellHeight - kStatusDockHeight-KTableViewCellMargin+2;
//    _dock.frame = fram;
}
//- (void)showRetweeted
//{
//    if ([self.delegate respondsToSelector:@selector(homeRetweetStatus:)]) {
//        [_delegate homeRetweetStatus:_dock.status];
//    }
//}
@end
