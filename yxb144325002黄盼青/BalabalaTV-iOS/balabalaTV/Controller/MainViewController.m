//
//  MainViewController.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/4.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "MainViewController.h"
#import "TVListTableViewCell.h"
#import "BBTVListModel.h"
#import "BBFileManager.h"
#import "BBPlayerViewController.h"
#import "BBSetViewController.h"

@interface MainViewController ()

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) BBSetViewController *settingVC;

@end

@implementation MainViewController

#pragma mark - ViewController Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //修改导航样式
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 100)];
    titleLabel.text = @"Balabala";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    self.navigationItem.titleView = titleLabel;
    
    //添加设置按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ico-setting"] style:UIBarButtonItemStylePlain target:self action:@selector(didSetBtnClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //初始化TableView
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    
    //iOS8以下旋转屏幕时不修改长宽值
    if(sysVersion.floatValue < 8.0f)
    {
        if(UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
        {
            CGSize newScreenSize = CGSizeMake(screenSize.height, screenSize.width);
            screenSize = newScreenSize;
        }
    }
    
    _tableView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    [_tableView reloadData];
    
    
}


#pragma mark - TableViewDataSource Protocol
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tvlistData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BBTVListModel *model = [self.tvlistData objectAtIndex:indexPath.row];
    NSString *logoFileName = [NSString stringWithFormat:@"%@.jpg",model.tvID];
    UIImage *logo =[UIImage imageWithData:[BBFileManager readDataFromFile:logoFileName withPathDirectory:NSCachesDirectory]];
    TVListTableViewCell *cell = [[TVListTableViewCell alloc]init];
    [cell setLogoImage:logo];
    [cell setTVName:model.tvName];
    [cell setSourceCount:model.source.count];
    [cell setPathRow:indexPath.row];
    [cell setBtnTarget:self andSelector:@selector(didPlayBtnClicked:)];
    
    return cell;
}

#pragma mark - TableViewDelegate Protocol
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==self.tvlistData.count-1)
    {
        return 127.0f;
    }
    return 117.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - 事件处理
-(void)didPlayBtnClicked:(NSNumber *)pathRow{
    BBTVListModel *model = [self.tvlistData objectAtIndex:pathRow.integerValue];
    BBPlayerViewController *playerVC = [[BBPlayerViewController alloc]init];
    [playerVC setVideoListURL:model.source];
    [playerVC play];
    
    [playerVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:playerVC animated:YES completion:nil];
    
}

-(void)didSetBtnClicked{
    @synchronized(self){
            if(!_settingVC){
                _settingVC = [[BBSetViewController alloc]init];
            }
            
            if(_settingVC.isSetDisplay){
                [_settingVC closeSettingPage];
            }else
            {
                [_settingVC showSettingPage:self];
            }
    }
}

@end
