//
//  PublicViewController.m
//  weiBo
//
//  Created by lixu on 15/1/9.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import "PublicViewController.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "UserModel.h"
#import "PersonCell.h"
#import "ContentCell.h"
#import "CommentCell.h"
#import "PublicLIneModel.h"


@interface PublicViewController ()<UIWebViewDelegate>
@property (strong,nonatomic) UserModel* userModel;

@end

@implementation PublicViewController


NSOperationQueue *serialQueue;
NSOperationQueue *mainQueue;
//初始化队列

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainQueue=[NSOperationQueue mainQueue];
    serialQueue=[[NSOperationQueue alloc] init];
    serialQueue.maxConcurrentOperationCount=1;
    //进行初始化
    
    _webRequest=[[webServiceApi alloc] init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounds=CGRectMake(0, 88, 320, 432);
    _navigationBar.bounds=CGRectMake(0, 0, 320, 88);
    [self setupRefresh];
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [_tableView  headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView  addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉可以刷新了";
    _tableView .headerReleaseToRefreshText = @"松开马上刷新了";
    _tableView .headerRefreshingText = @"数据正在刷新，请稍后……";
    
    _tableView .footerPullToRefreshText = @"上拉可以加载更多数据了";
    _tableView .footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _tableView .footerRefreshingText = @"数据正在刷新，请稍后……";
}
- (void)headerRereshing

{
    [serialQueue addOperationWithBlock:^{
        _plkArray=[_webRequest requestForPublicTimeLinePageCount:20];
        [mainQueue addOperationWithBlock:^{
            [_tableView  reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_tableView  headerEndRefreshing];
        }];
    }];
}

- (void)footerRereshing
{
    
    [serialQueue addOperationWithBlock:^{
        _plkArray=[_webRequest requestForPublicTimeLinePageCount:20];
        [mainQueue addOperationWithBlock:^{
            [_tableView  reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_tableView  headerEndRefreshing];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_plkArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 57;
    }else if (indexPath.row==1){
        return 114;
    }else{
        return 35;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        static NSString *cellIdentifier=@"PersonCell";
        UINib *nib=[UINib nibWithNibName:cellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell=[[PersonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        PublicLIneModel *model=[_plkArray objectAtIndex:indexPath.section];
        UserModel *userModel=model.userModel;
        NSString *imageURL=userModel.profile_image_url;
        NSLog(@"+++++++++++++%@+++++++++" ,userModel.profile_image_url);
        NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        cell.userImage.image=[UIImage imageWithData:imageData];
        cell.userName.text=userModel.name;
        cell.time.text=model.created_at;
        cell.source.text=userModel.location;
        return cell;
    }
    
    else if (indexPath.row==1) {
        static NSString* cellIdentifier=@"ContentCell";
        UINib *nib=[UINib nibWithNibName:cellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        ContentCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell=[[ContentCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        PublicLIneModel *model=[_plkArray objectAtIndex:indexPath.section];
        NSString* imageURL=model.bmiddle_pic;
        NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        NSLog(@"+++++++++%@++++++++++",imageURL);
        cell.contentImage1.image=[UIImage imageWithData:imageData];
        cell.contextText.text=model.text;
        return cell;
    }
    
    else {
        static NSString *cellIdentifier=@"CommentCell";
        UINib *nib=[UINib nibWithNibName:cellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        CommentCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell=[[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }
}

- (IBAction)share:(id)sender {
}

- (IBAction)comment:(id)sender {
}

- (IBAction)favour:(id)sender {
}
@end

