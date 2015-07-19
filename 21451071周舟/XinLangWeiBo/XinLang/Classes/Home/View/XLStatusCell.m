//
//  XLStatusCell.m
//  XinLang
//
//  Created by 周舟 on 14-10-3.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLStatusCell.h"
#import "XLStatusToolBar.h"
#import "XLStatusTopView.h"
#import "XLStatusFrame.h"

@interface XLStatusCell()

@property (nonatomic, weak) XLStatusTopView *topView;
@property (nonatomic, weak) XLStatusToolBar *toolBar;

@end

@implementation XLStatusCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        
        // 1.添加微博顶部view
        [self setupTopView];
        
        //2.添加微博底部工具栏
        [self setupToolBar];
    }
    
    return self;
}

- (void)setupTopView
{
    XLStatusTopView *topView = [[XLStatusTopView alloc] init];
    
    
    [self addSubview:topView];
    self.topView = topView;
    
}

- (void)setupToolBar
{
    XLStatusToolBar *toolBar = [[XLStatusToolBar alloc] init];
    
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

- (void)setStatusFrame:(XLStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //1设置顶部view的数据
    [self setTopViewData];
    //2.设置微博工具条的数据
    [self setToolBarData];
}

- (void)setTopViewData
{
    self.topView.frame = self.statusFrame.topViewF;
    self.topView.statusFrame = self.statusFrame;
}

- (void)setToolBarData
{
    self.toolBar.frame = self.statusFrame.statusToolbarF;
    self.toolBar.status = self.statusFrame.status;
    
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


@end
