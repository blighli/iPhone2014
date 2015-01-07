//
//  XLHomeViewController.m
//  XinLang
//
//  Created by 周舟 on 14-10-1.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLHomeViewController.h"
#import "UIBarButtonItem+MJ.h"
#import <AFNetworking/AFNetworking.h>
#import "XLAccountTool.h"
#import "XLAccount.h"
#import "XLStatus.h"
#import "XLUser.h"
#import "XLStatusCell.h"
#import "XLStatusFrame.h"
#import "XLPhotosView.h"
#import "XLStatusTopView.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "XLTitleButton.h"
#import "XLDetailViewController.h"
#import "XLNavationViewController.h"
#import "XLReweetStatusView.h"
#import "XLBaseStatusFrame.h"
#import "XLStatusTool.h"
#import "XLHomeStatusParam.h"
#import "XLHomeStatusResult.h"



static NSString *CellIdentifier = @"cell";

@interface XLHomeViewController ()<MJRefreshBaseViewDelegate>

@property(nonatomic, weak) MJRefreshFooterView *footer;
@property(nonatomic, weak) MJRefreshHeaderView *header;
@property(nonatomic, weak) XLTitleButton *titleButton;


@property(nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation XLHomeViewController
/**
 *  get statusFrames 数组时调用
 *  若未生成数组则生成后返回
 *  @return 数组
 */
- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
        
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = XLColor(250, 250, 250);
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 10, 0);
  
    [self setupRefresh];
    [self addButtonToNav];
    [self loadNewData];
    
                        
}

/**
 *  设置导航栏item
 */
- (void) addButtonToNav
{
    //self.title = [XLAccountTool account].name;
    NSLog(@"%@",[XLAccountTool account]);
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(searchFriend:)];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(scanSearh:)];
    
    //中间按钮
    XLTitleButton *btn = [[XLTitleButton alloc] init];
    
    self.navigationItem.titleView = btn;
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 0, 40);
    //NSLog(@"----name:%@",[XLAccountTool account]);

   [btn setTitle:@"首页" forState:UIControlStateNormal];
   
    self.navigationItem.titleView = btn;
    self.titleButton = btn;
    
    
}


- (void) setupRefresh
{
    //1. 下拉刷新
    MJRefreshHeaderView *header = [[MJRefreshHeaderView alloc]init];
    header.scrollView = self.tableView;
    header.delegate = self;
    self.header = header;
    
    //2.上拉刷新
    MJRefreshFooterView *footer = [[MJRefreshFooterView alloc] init];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}
/**
 *  释放上，下拉刷新控件
 */
-(void)dealloc
{
    [self.header free];
    [self.footer free];
}
/**
 *  上下拉刷新控件代理
 *
 *  @param refreshView 上，下拉控件
 */

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        [self loadMoreData];
    }else{
        [self loadNewData];
    }
}

- (void)loadMoreData
{
    XLHomeStatusParam *param = [XLHomeStatusParam param];
    if (self.statusFrames.count)
    {
        XLStatusFrame *statusFrame = [self.statusFrames lastObject];
        param.max_id = @([statusFrame.status.idstr longLongValue] - 1);
    }
    
    //2
    [XLStatusTool homeStatusesWithParam:param success:^(XLHomeStatusResult *result) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (XLStatus *status in result.statuses)
        {
            XLStatusFrame *statusFrame = [[XLStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        //
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        
        //刷新表格
        [self.tableView reloadData];
        //停止刷新
        [self.footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.footer endRefreshing];
    }];
    
}
/**
 *  刷新
 */
- (void)refresh
{
    [self.header beginRefreshing];
}
/**
 *  下载新数据
 */

- (void)loadNewData
{
    self.tabBarItem.badgeValue = nil;
    XLHomeStatusParam *param = [XLHomeStatusParam param];
    
    if (self.statusFrames.count)
    {
        XLStatusFrame *statusFrame = self.statusFrames[0];
        param.since_id = @([statusFrame.status.idstr longLongValue]);
        
    }
    //2.
    [XLStatusTool homeStatusesWithParam:param success:^(XLHomeStatusResult *result) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        
        for (XLStatus *status in result.statuses)
        {
            XLStatusFrame *statusFrame = [[XLStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 将最新的数据追加到旧数据的最前面
        // 旧数据: self.statusFrames
        // 新数据: statusFrameArray
        NSMutableArray *tempArray = [NSMutableArray array];
        //
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        //停止刷新显示状态
        [self.header endRefreshing];
        
        [self showNewStatusCount:(int)statusFrameArray.count];
        
    } failure:^(NSError *error) {
        NSLog(@"failure!");
        [self.header endRefreshing];
    }];
}

- (void)showNewStatusCount:(int)count
{
    //1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    //2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新微薄",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
        
    }
    //3.设置按钮的厨师frame
    CGFloat btnH = 30;
    CGFloat btnX = 0;
    CGFloat btnY = 64 - btnH;
    CGFloat btnW = self.view.frame.size.width;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    //4动画
    [UIView animateWithDuration:1 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
            
        }];
    }];
}

- (void)searchFriend:(UIBarButtonItem*)item
{
    NSLog(@"searchFriend");
}


- (void)scanSearh:(UIBarButtonItem*)item
{
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XLStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[XLStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.statusFrame = self.statusFrames[indexPath.row];
    

    //NSLog(@"---cell--:%@",cell);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellheight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XLDetailViewController *detail = [[XLDetailViewController alloc] init];
 
    
    XLStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    XLStatus *status = statusFrame.status;
    detail.status = status;

    [self.navigationController pushViewController:detail animated:YES];
    
    
}




@end
