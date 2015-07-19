//
//  XLDetailCell.m
//  XinLang
//
//  Created by 周舟 on 14-10-13.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLDetailCell.h"
#import "XLStatusTopView.h"
#import "XLDetailStatusFrame.h"
#import "XLBaseStatusFrame.h"
#import "XLStatusTopView.h"
#import "XLDetailViewController.h"
#import "XLNavationViewController.h"
#import "XLStatus.h"
#import "XLTabBarViewController.h"


@interface XLDetailCell()

@property (nonatomic, weak) XLStatusTopView *topView;
@end

@implementation XLDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        
        // 1.添加微博顶部view
        [self setupTopView];
        
        [self.topView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweeted)]];
        
    }
    
    return self;
}

- (void)setupTopView
{
    XLStatusTopView *topView = [[XLStatusTopView alloc] init];
    
    
    [self addSubview:topView];
    self.topView = topView;
    
}


- (void)setStatusFrame:(XLDetailStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //1设置顶部view的数据
    
    [self setTopViewData];
    

}
- (void)setTopViewData
{
    self.topView.frame = self.statusFrame.topViewF;
    self.topView.statusFrame = (XLBaseStatusFrame *)self.statusFrame;
}

-(void)setFrame:(CGRect)frame
{
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat cellH = self.statusFrame.cellheight + XLStatusTableBorder;
    frame.origin.y += XLStatusTableBorder;
    frame.origin.x = 0;
    frame.size.width = cellW;
    frame.size.height = cellH;
    [super setFrame:frame];
    
}


#pragma mark 显示转发微博
- (void)showRetweeted
{
    XLStatus *retStatus = self.statusFrame.status.retweeted_status;
    if (retStatus) {
        XLDetailViewController *detail = [[XLDetailViewController alloc] init];
        
        detail.status = retStatus;
        XLTabBarViewController *main = (XLTabBarViewController *)self.window.rootViewController;
        
        UINavigationController *nav = (UINavigationController *)main.selectedViewController;
        [nav pushViewController:detail animated:YES];
    }
    

}



@end
