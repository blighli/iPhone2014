//
//  HomeViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/3.
//  Copyright (c) 2014年 hj. All rights reserved.
//
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "Status.h"
#import "StatusCellFrame.h"
#import "StatusCell.h"
#import "HttpTool.h"
#import "MJRefresh.h"
#import "UIImage+MJ.h"
#import "UIBarButtonItem+MJ.h"
#import "StatusDetailController.h"
#import "UIViewController+MMDrawerController.h"
#import "User.h"
#import "LeftViewController.h"

@interface HomeViewController ()<UIAlertViewDelegate, leftSelectedFeatureDelegate>
{
    NSMutableArray *_statusesFrame;
    User *_user;
    NSString *_feature;
    BOOL _more;
}
@property (nonatomic, strong) AppDelegate *myDelegate;

@end

@implementation HomeViewController

- (void)didSelectedHidenSwitch:(BOOL)hidden{
    [_delegate didSelectedHidenSwitch:hidden];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _statusesFrame = [NSMutableArray array];
    //home 的数值
    _feature = [NSString stringWithFormat:@"0"];
    _more = YES;
    //left
    LeftViewController *left = [[LeftViewController alloc] init];
    [self.mm_drawerController setLeftDrawerViewController:left];
    left.degetalte = self;
    //创建TableView
    self.tableView.backgroundColor = KGlobalBackColour;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_myDelegate
    _myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    //_myDelegate.delegate = self;
    //微博按钮
    UIBarButtonItem *bindItem = [UIBarButtonItem itemWithIcon:@"navigationbar_compose.png"
                                              highlightedIcon:@"navigationbar_compose_highlighted.png" target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = bindItem;
    //left按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop.png"
                                             highlightedIcon:@"navigationbar_pop_highlighted.png" target:self action:@selector(swipe:)];
    // 集成刷新控件
    [self setupRefresh];
}
#pragma mark - left的代理方法
- (void)didSelectedFrature:(NSString *)feature
{
    _feature = feature;
    [_statusesFrame removeAllObjects];
    [self.tableView reloadData];
    [self.tableView headerBeginRefreshing];
}
- (void)didSelectedMoreWitch:(BOOL)more
{
    _more = more;
}
#pragma mark - 实现详细转发微博代理
- (void)homeRetweetStatus:(Status *)status
{
    StatusDetailController *detail = [[StatusDetailController alloc]init];
    if (status.retweetedStatus) {
        detail.status = status.retweetedStatus;
    }else{
        detail.status = status;
    }
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)login
{
    _user = _myDelegate.user;
    self.navigationItem.title = _user.screenName;
    [self.tableView headerBeginRefreshing];
}
- (void)startAction
{
    _user = _myDelegate.user;
    self.navigationItem.title = _user.screenName;
}
#pragma mark - 集成上下拉控件
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark - 开始进入刷新状态
- (void)headerRereshing
{
    StatusCellFrame *f = _statusesFrame.count?_statusesFrame[0]:nil;
    long long first = [f.status ID];
    NSString *sinceID = [NSString stringWithFormat:@"%lld",first];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setObject:sinceID forKey:@"since_id"];
    [params setObject:@"20" forKey:@"count"];
    if (_feature!=nil) {
        [params setObject:_feature forKey:@"feature"];
    }

    [HttpTool wbHttpRequest:@"statuses/home_timeline.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
        if (!error) {
            //NSLog(@"%@",result);
            NSMutableArray *_statuses = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in result[@"statuses"])
            {
                Status *s = [[Status alloc]initWithDict: dict];
                [_statuses addObject:s];
            }
            NSMutableArray *newFrames = [NSMutableArray array];
            for (Status *s1 in _statuses) {
                StatusCellFrame *f = [[StatusCellFrame alloc] init];
                f.status = s1;
                [newFrames addObject:f];
            }
            // 2.将newFrames整体插入到旧数据的前面
            [_statusesFrame insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];

            // 3.刷新表格
            [self.tableView reloadData];
            // 5.顶部展示最新微博的数目
            [self showNewStatusCount:_statuses.count];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请求异常（可能没登录）"
                                               message:@"测试帐号:hvebotest@163.com\n密码:hvebotest163"
                                              delegate:nil
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles:@"登录",nil];
            alert.delegate = self;
            [alert show];
        }
    }];
    [self.tableView headerEndRefreshing];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kRedirectURI;
        request.scope = @"all";
        [WeiboSDK sendRequest:request];
    }
}
#pragma mark 展示最新微博的数目
- (void)showNewStatusCount:(NSInteger)count
{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.enabled = NO;
    btn.adjustsImageWhenDisabled = NO;
    
    [btn setBackgroundImage:[UIImage resizedImage:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
    CGFloat w = self.view.frame.size.width;
    CGFloat h = 30;
    btn.frame = CGRectMake(0, 34, w, h);
    NSString *title = count?[NSString stringWithFormat:@"%ld条新的微博", (long)count]:@"没有新的微博";
    [btn setTitle:title forState:UIControlStateNormal];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.开始执行动画
    CGFloat duration = 0.5;
    
    [UIView animateWithDuration:duration animations:^{ // 下来
        btn.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{// 上去
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}
#pragma mark 上拉加载更多
- (void)footerRereshing
{
    // 1.最后1条微博的ID 加载更多微博
    long long last = [[[_statusesFrame lastObject] status] ID]-1;
    NSString *lastID = [NSString stringWithFormat:@"%lld",last];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setObject:lastID forKey:@"max_id"];
    [params setObject:@"20" forKey:@"count"];
    if (_feature!=nil) {
        [params setObject:_feature forKey:@"feature"];
    }
    [HttpTool wbHttpRequest:@"statuses/home_timeline.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
        if (!error) {
            NSMutableArray *_statuses = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in result[@"statuses"])
            {
                Status *s = [[Status alloc]initWithDict: dict];
                [_statuses addObject:s];
            }
    
            NSMutableArray *newFrames = [NSMutableArray array];
            for (Status *s1 in _statuses) {
                StatusCellFrame *f = [[StatusCellFrame alloc] init];
                f.status = s1;
                [newFrames addObject:f];
            }
            
            // 2.将newFrames整体插入到旧数据的后面
            [_statusesFrame addObjectsFromArray:newFrames];
            
            // 3.刷新表格
            [self.tableView reloadData];
        }
    }];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
}
#pragma mark - button actions
- (void)bindAction:(UIBarButtonItem *)buttonItem
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
- (void)swipe:(UIBarButtonItem *)buttonItem
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
#pragma mark - 每一个cell的高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_statusesFrame[indexPath.row] cellHeight];
}
#pragma mark - tableView date sourse
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusesFrame.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.statusCellFrame = _statusesFrame[indexPath.row];
    //cell.delegate = self;
    if (([tableView numberOfRowsInSection:indexPath.section]-indexPath.row) < 4 && _more) {
        [self footerRereshing];
    }
    return cell;
}
#pragma mark 监听cell的点击
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    StatusDetailController *detail = [[StatusDetailController alloc] init];
//    StatusCellFrame *f = _statusesFrame[indexPath.row];
//    detail.status = f.status;
//    [self.navigationController pushViewController:detail animated:YES];
//}
@end
