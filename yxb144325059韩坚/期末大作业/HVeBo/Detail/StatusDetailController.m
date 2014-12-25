//
//  StatusDetailController.m
//  HVeBo
//
//  Created by HJ on 14/12/14.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "StatusDetailController.h"
#import "StatusDetailCell.h"
#import "StatusDetailCellFrame.h"
#import "DetailHeader.h"
#import "HttpTool.h"
#import "Status.h"
#import "UIViewController+MMDrawerController.h"
#import "CommentCellFrame.h"
#import "repostCellFrame.h"
#import "Comment.h"
#import "repostCell.h"
#import "commentCell.h"
#import "MJRefresh.h"
#import "UIBarButtonItem+MJ.h"

@interface StatusDetailController ()<DetailHeaderDelegate>
{
    StatusDetailCellFrame *_detailFrame;
    DetailHeader *_detailHeader;
    NSMutableArray *_repostFrmaes;//所有的转发数据
    NSMutableArray *_commentFrames;//所有的评论数据
    BOOL _commentLastPage;
    BOOL _repostLastPage;
}
@end

@implementation StatusDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博正文";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KGlobalBackColour;
    
    _repostFrmaes = [NSMutableArray array];
    _commentFrames = [NSMutableArray array];
    _detailFrame = [[StatusDetailCellFrame alloc]init];
    _detailFrame.status = _status;
    //tableview
    self.tableView.backgroundColor = KGlobalBackColour;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //登录按钮
    UIBarButtonItem *bindItem = [UIBarButtonItem itemWithIcon:@"navigationbar_more.png"
                                              highlightedIcon:@"navigationbar_more_highlighted.png" target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = bindItem;

    // 集成刷新控件
    [self setupRefresh];
    
    _detailHeader = [DetailHeader header];
    _detailHeader.delegate = self;
    [self loadNewComment];
}
- (void)viewWillAppear:(BOOL)animated
{
//    [self.mm_drawerController setLeftDrawerViewController:nil];
//    [self.mm_drawerController setRightDrawerViewController:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
//    LeftViewController *left = [[LeftViewController alloc]init];
//    [self.mm_drawerController setLeftDrawerViewController:left];
//    RightViewController *right = [[RightViewController alloc]init];
//    [self.mm_drawerController setRightDrawerViewController:right];
}
#pragma mark - 集成上下拉控件
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.tableView.footerHidden = YES;
}
#pragma mark - 下拉
- (void)headerRereshing
{
    [self statausWithID];
    if(_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment){
        [self loadNewComment];
    }else {
        [self loadNewRepost];
    }
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}
#pragma mark - 上拉
- (void)footerRereshing
{
    if(_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment){
        [self loadMoreComment];
    }else {
        [self loadMoreRepost];
    }
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
}
#pragma mark - 详细转发微博代理
- (void)retweetStatus:(Status *)status
{
    StatusDetailController *detail = [[StatusDetailController alloc]init];
    if (status.retweetedStatus) {
        detail.status = status.retweetedStatus;
    }else{
        detail.status = status;
    }
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - 按钮事件
- (void)bindAction:(UIBarButtonItem *)buttonItem
{

}
#pragma mark - 获得当前需要使用的数组
- (NSMutableArray *)currentArray
{
    if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment) {
        return  _commentFrames;
    }else{
        return  _repostFrmaes;
    }
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment) {
        self.tableView.footerHidden = _commentLastPage;
    }else{
        self.tableView.footerHidden = _repostLastPage;
    }
    return 2;
}
#pragma mark - section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 41;
}
#pragma mark - 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section? self.currentArray.count:1;
}
#pragma mark - - 头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0) return nil;
    _detailHeader.status = _status;
    return _detailHeader;
}
#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _detailFrame.cellHeight;
    }else{
        if (self.currentArray.count*41 < ([UIScreen mainScreen].bounds.size.height - 44)) {
            if(indexPath.row == ([self currentArray].count-1)){
                return [UIScreen mainScreen].bounds.size.height - (self.currentArray.count+1)*41;
            }
        }
    }
    return indexPath.section?[self.currentArray[indexPath.row] cellHeight]:_detailFrame.cellHeight;
}
#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"DetailCell";
        StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[StatusDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.statusCellFrame = _detailFrame;
        //cell.delegate = self;
        return cell;
    }else if(_detailHeader.currentBtnType == kDetailHeaderBtnTypeComment){//评论cell
        static NSString *CellIdentifier = @"commentCell";
        commentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[commentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.cellFrame = _commentFrames[indexPath.row];
        return cell;
    }else {//转发cell
        static NSString *CellIdentifier = @"repostCell";
        repostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[repostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.cellFrame = _repostFrmaes[indexPath.row];
        return cell;
    }
}
#pragma mark - cell能不能被选中
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
#pragma mark - 代理头部显示转发评论
- (void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index
{
    //防止网速慢时出现问题
    [self.tableView reloadData];
    if (index == kDetailHeaderBtnTypeComment){//点击了评论
        [self loadNewComment];
    }else if(index == kDetailHeaderBtnTypeRepost){//点击了转发
        [self loadNewRepost];
    }
}
#pragma mark - 解析最新数据
- (NSMutableArray *)frameWithMosels:(NSArray *)models class:(Class)class
{
    NSMutableArray *newFrames = [NSMutableArray array];
    for (BaseText *c in models) {
        BaseTextCellFrame *f = [[class alloc] init];
        f.baseText = c;
        [newFrames addObject:f];
    }
    return newFrames;
}
#pragma mark - 加载最新的评论
- (void)loadNewComment
{
    long long firstID = _commentFrames.count?[[_commentFrames[0] baseText] ID]:0;
    NSString *sinceID = [NSString stringWithFormat:@"%lld",firstID];
    NSString *statusID = [NSString stringWithFormat:@"%lld",_status.ID];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    [params setObject:statusID forKey:@"id"];
    [params setObject:sinceID forKey:@"since_id"];
    //[params setObject:@"5" forKey:@"count"];
    [HttpTool wbHttpRequest:@"comments/show.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
        if (!error) {
            NSMutableArray *comment = [NSMutableArray array];
            for (NSDictionary *dict in result[@"comments"])
            {
                BaseText *c = [[Comment alloc]initWithDict: dict];
                [comment addObject:c];
            }
            NSMutableArray *newFrames = [self frameWithMosels:comment class:[CommentCellFrame class]];
            _status.commentCount = [result[@"total_number"] intValue];
            _commentLastPage = [result[@"next_cursor"] longLongValue] == 0;
            [_commentFrames insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
            [self.tableView reloadData];
        }else{
            NSLog(@"获取评论失败");
        }
    }];
}
#pragma mark - 加载最新的转发
- (void)loadNewRepost
{
    long long firstID = _repostFrmaes.count?[[_repostFrmaes[0] baseText] ID]:0;
    NSString *sinceID = [NSString stringWithFormat:@"%lld",firstID];
    NSString *statusID = [NSString stringWithFormat:@"%lld",_status.ID];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    [params setObject:statusID forKey:@"id"];
    [params setObject:sinceID forKey:@"since_id"];
    [HttpTool wbHttpRequest:@"statuses/repost_timeline.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
        if (!error) {
            NSMutableArray *status = [NSMutableArray array];
            for (NSDictionary *dict in result[@"reposts"])
            {
                BaseText *c = [[Status alloc]initWithDict: dict];
                [status addObject:c];
            }
            NSMutableArray *newFrames = [self frameWithMosels:status class:[repostCellFrame class]];
            _status.repostsCount = [result[@"total_number"] intValue];
            _repostLastPage = [result[@"next_cursor"] longLongValue] == 0;
            [_repostFrmaes insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
            [self.tableView reloadData];
        }else{
            NSLog(@"获取转发失败");
        }
    }];
}
#pragma mark - 加载更多的评论
- (void)loadMoreComment
{
    long long firstID = [[[_commentFrames lastObject] baseText] ID]-1;
    NSString *sinceID = [NSString stringWithFormat:@"%lld",firstID];
    NSString *statusID = [NSString stringWithFormat:@"%lld",_status.ID];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    [params setObject:statusID forKey:@"id"];
    [params setObject:sinceID forKey:@"max_id"];
    [HttpTool wbHttpRequest:@"comments/show.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
        if (!error) {
            NSMutableArray *comment = [NSMutableArray array];
            for (NSDictionary *dict in result[@"comments"])
            {
                BaseText *c = [[Comment alloc]initWithDict: dict];
                [comment addObject:c];
            }
            NSMutableArray *newFrames = [self frameWithMosels:comment class:[CommentCellFrame class]];
            _status.commentCount = [result[@"total_number"] intValue];
            _commentLastPage = [result[@"next_cursor"] longLongValue] == 0;
            [_commentFrames addObjectsFromArray:newFrames];
            [self.tableView reloadData];
            
        }else{
            NSLog(@"获取评论失败");
        }
    }];
}
#pragma mark - 加载更多的转发
- (void)loadMoreRepost
{
    long long firstID = [[[_repostFrmaes lastObject] baseText] ID]-1;
    NSString *sinceID = [NSString stringWithFormat:@"%lld",firstID];
    NSString *statusID = [NSString stringWithFormat:@"%lld",_status.ID];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    [params setObject:statusID forKey:@"id"];
    [params setObject:sinceID forKey:@"max_id"];
    [HttpTool wbHttpRequest:@"statuses/repost_timeline.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
        if (!error) {
            NSMutableArray *status = [NSMutableArray array];
            for (NSDictionary *dict in result[@"reposts"])
            {
                BaseText *c = [[Status alloc]initWithDict: dict];
                [status addObject:c];
            }
            NSMutableArray *newFrames = [self frameWithMosels:status class:[repostCellFrame class]];
            _status.repostsCount = [result[@"total_number"] intValue];
            _repostLastPage = [result[@"next_cursor"] longLongValue] == 0;
            [_repostFrmaes addObjectsFromArray:newFrames];
            [self.tableView reloadData];
        }else{
            NSLog(@"获取转发失败");
        }
    }];
}
#pragma mark - 单条微博
- (void)statausWithID
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    NSString *statusID = [NSString stringWithFormat:@"%lld",_status.ID];
    [params setObject:statusID forKey:@"id"];

    [HttpTool wbHttpRequest:@"statuses/show.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
        if (!error) {
             
            _status = [[Status alloc] initWithDict:result];
            _detailFrame.status = _status;
            [self.tableView reloadData];
            //NSLog(@"%@",result);
        }else{
            NSLog(@"获取单条微博失败");
        }
    }];
}
@end
