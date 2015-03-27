//
//  MessageViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/14.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "MessageViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIButton+HJ.h"
#import "HttpTool.h"
#import "MJRefresh.h"
#import "StatusCellFrame.h"
#import "Status.h"
#import "StatusCell.h"
#import "UIImage+MJ.h"
#import "StatusDetailController.h"
#import "UIBarButtonItem+MJ.h"

@interface MessageViewController ()
{
    NSMutableArray *_statusesFrame;
    NSMutableArray *_commentFrame;
    UIButton *_selectButton;
    NSString *_url;
    NSString *_nowType;
}

@end

@implementation MessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self initViews];
    // 集成刷新控件
    [self setupRefresh];
}
- (void)messageAction:(UIButton *)btn
{
    
    _selectButton.enabled = YES;
    btn.enabled = NO;
    _selectButton = btn;
    
    if (btn.tag == 40) {
        _url = @"statuses/mentions.json";
        _nowType = @"statuses";
    }else if(btn.tag == 41){
        _nowType = @"comments";
        _url = @"comments/timeline.json";
    }
    if ([self currentArray] != nil) {
        [self.tableView reloadData];
    }
    if (btn.tag < 42) {
        [self headerRereshing];
    }
    
}
#pragma mark - 获得当前需要使用的数组
- (NSMutableArray *)currentArray
{
    if ([_nowType  isEqual: @"statuses"]) {
        return  _statusesFrame;
    }else{
        return  _commentFrame;
    }
}
- (void)initViews
{
    _statusesFrame = [NSMutableArray array];
    _commentFrame = [NSMutableArray array];
    _url = @"statuses/mentions.json";
    _nowType = @"statuses";
    //创建TableView
    self.tableView.backgroundColor = KGlobalBackColour;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //
    UIView *titleView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    
    NSArray *buttonArray = [NSArray arrayWithObjects:
                            @"navigationbar_mentions.png",
                            @"navigationbar_comments.png",
                            @"navigationbar_messages.png",
                            @"navigationbar_notice.png",
                            nil];
    for (int i=0; i < buttonArray.count; i++) {
        UIButton *btn = [UIButton itemWithIcon:buttonArray[i] highlightedIcon:nil target:self action:@selector(messageAction:)];
        btn.showsTouchWhenHighlighted = YES;
        btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*i/4+30, 10, 22, 22);
        btn.tag = 40 + i;
        [titleView addSubview:btn];
        if (i == 0) {
            btn.enabled = NO;
            _selectButton = btn;
        }
    }
    self.navigationItem.titleView = titleView;
}


#pragma - 实现详细转发微博代理
- (void)homeRetweetStatus:(Status *)status
{
    StatusDetailController *detail = [[StatusDetailController alloc]init];
    detail.status = status.retweetedStatus;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma - 集成上下拉控件
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    StatusCellFrame *f = [self currentArray].count?[self currentArray][0]:nil;
    
    long long first = [f.status ID];
    NSString *sinceID = [NSString stringWithFormat:@"%lld",first];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setObject:sinceID forKey:@"since_id"];
    [params setObject:@"50" forKey:@"count"];
    
    [HttpTool wbHttpRequest:_url httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
        if (!error) {
            //NSLog(@"%@",result);
            NSMutableArray *_statuses = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in result[_nowType])
            {
                Status *s = [[Status alloc]initWithDict: dict];
                [_statuses addObject:s];
            }
            //NSLog(@"%@",result);
            NSMutableArray *newFrames = [NSMutableArray array];
            for (Status *s1 in _statuses) {
                StatusCellFrame *f = [[StatusCellFrame alloc] init];
                f.status = s1;
                [newFrames addObject:f];
            }
            
            [[self currentArray] insertObjects:newFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)]];
 
            // 3.刷新表格
            [self.tableView reloadData];
            // 5.顶部展示最新微博的数目
            //[self showNewStatusCount:_statuses.count];
        }
    }];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}
#pragma mark 展示最新微博的数目
//- (void)showNewStatusCount:(NSInteger)count
//{
//    // 1.创建按钮
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.enabled = NO;
//    btn.adjustsImageWhenDisabled = NO;
//    
//    [btn setBackgroundImage:[UIImage resizedImage:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
//    CGFloat w = self.view.frame.size.width;
//    CGFloat h = 30;
//    btn.frame = CGRectMake(0, 34, w, h);
//    NSString *title = count?[NSString stringWithFormat:@"%ld条新的消息", (long)count]:@"没有新的消息";
//    [btn setTitle:title forState:UIControlStateNormal];
//    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
//    
//    // 2.开始执行动画
//    CGFloat duration = 0.5;
//    
//    [UIView animateWithDuration:duration animations:^{ // 下来
//        btn.transform = CGAffineTransformMakeTranslation(0, h);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{// 上去
//            btn.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            [btn removeFromSuperview];
//        }];
//    }];
//}
#pragma mark 上拉加载更多
- (void)footerRereshing
{
    long long last = [[[[self currentArray] lastObject] status] ID]-1;
    
    NSString *lastID = [NSString stringWithFormat:@"%lld",last];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setObject:lastID forKey:@"max_id"];
    [params setObject:@"50" forKey:@"count"];
    [HttpTool wbHttpRequest:_url httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
        if (!error) {
            NSMutableArray *_statuses = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in result[_nowType])
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

#pragma mark - 每一个cell的高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self currentArray][indexPath.row] cellHeight];
}
#pragma mark - tableView date sourse
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self currentArray].count;

}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.statusCellFrame = [self currentArray][indexPath.row];

    //cell.delegate = self;
    return cell;
}
#pragma mark 监听cell的点击
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    StatusDetailController *detail = [[StatusDetailController alloc] init];
//  
//    detail.status= [[self currentArray][indexPath.row] status];
//
//    
//    [self.navigationController pushViewController:detail animated:YES];
//}

@end
