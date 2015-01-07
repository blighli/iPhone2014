//
//  XLDetailViewController.m
//  XinLang
//
//  Created by 周舟 on 14-10-13.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLDetailViewController.h"
#import "UIBarButtonItem+MJ.h"
#import "XLDetailCell.h"
#import "XLStatusFrame.h"
#import "XLStatusTopView.h"
#import "XLReweetStatusView.h"
#import "XLStatus.h"
#import "XLDetailStatusFrame.h"
#import "XLDetailToolbar.h"
#import "XLDetailCommentFrame.h"
#import "XLCommentCell.h"
#import "XLDetailCommentFrame.h"


static NSString *StatusDetailCell = @"DetailCell";
static NSString *CommentDetailCell = @"CommentDetailCell";

@interface XLDetailViewController()<UITableViewDataSource,UITableViewDelegate>
/**
 *  利用status数据构建自己的frame模型
 */
@property (nonatomic, strong) XLDetailStatusFrame *statusFrame;
/**
 *  评论的frames
 */
@property (nonatomic, strong) NSMutableArray *commetnFrames;

/**
 *  存储转发的frames
 */
@property (nonatomic, strong) NSMutableArray *retweetedFrames;

/**
 *  工具栏
 */
@property (nonatomic, weak) XLDetailToolbar *toolbar;

/**
 *  表格
 */
@property (nonatomic, weak ) UITableView *tableView;



@end

@implementation XLDetailViewController
//TODO:
- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加tableview
    [self setupTableView];
    //添加导航栏按钮
    [self setupNavBar];
    //添加工具栏
    [self setupToolBar];
    //设置数据
    [self setupData];
    
    
    
}



#pragma mark 初始化工作

-(NSMutableArray *)retweetedFrames
{
    if(_retweetedFrames == nil){
        _retweetedFrames = [NSMutableArray array];
    }
    return _retweetedFrames;
}

- (NSMutableArray *)commetnFrames
{
    if(_commetnFrames != nil){
        _commetnFrames = [NSMutableArray array];
    }
    return _commetnFrames;
}

- (void)setupData
{
    _statusFrame = [[XLDetailStatusFrame alloc] init];
    _statusFrame.status =  self.status;
    [self.tableView reloadData];
}

/**
 *  设置tableview
 */
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = XLColor(240, 240, 240);
    //NSLog(@"--XLDetailViewController:frame%@",NSStringFromCGRect(self.view.frame));
    tableView.frame = self.view.frame;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
}

/**
 *  设置工具栏
 */
- (void)setupToolBar
{

    
    //
    XLDetailToolbar *toolbar = [[XLDetailToolbar alloc] init];
    toolbar.status = self.status;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarH = 44;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    //添加toolbar
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}


/**
 *  设置导航栏
 */
- (void)setupNavBar
{
    //背景色
    self.view.backgroundColor = XLColor(232, 232, 232);
    //左边按钮
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithIcon:@"navigationbar_back" highIcon:@"navigationbar_back_highlighted" target:self action:@selector(leftClick)];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_more" highIcon:@"navigationbar_more_highlighted" target:self action:@selector(shareClick)];
    self.title                             = @"微博正文";
    
}
#pragma mark 导航栏触发事件

-(void)shareClick
{
    
}

- (void)leftClick
{
    //NSLog(@"leftClick");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableview代理方法


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        XLDetailCell *cell = (XLDetailCell *)[tableView dequeueReusableCellWithIdentifier:StatusDetailCell];
        if(cell == nil)
        {
            cell = [[XLDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:StatusDetailCell];
            
        }
        
        cell.statusFrame = self.statusFrame;
        
        //NSLog(@"---cell:%@",cell);
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentDetailCell];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CommentDetailCell];
        }
        //cell.statusFrame = self.commetnFrames[indexPath];
        cell.textLabel.text = @"comment";
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return self.statusFrame.cellheight;
    }else{
        return 64;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 下载数据
/**
 *  下载新的转发数据
 */
- (void)loadMoreRetweets
{
    
}

/**
 *  下载新的评论
 */
- (void)loadMoreComments
{
    
}



@end
