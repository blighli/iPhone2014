//
//  ChannelViewController.m
//  NetMusic
//
//  Created by xsdlr on 14/12/4.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "ChannelViewController.h"
#import "GlobalDefine.h"
#import "QCBBaseRequest+SongRequest.h"
#import "MBProgressHUD.h"

@interface ChannelViewController ()
@property(assign,nonatomic) NSInteger radius;
@property(strong,nonatomic) UITableView *channelTable;
@property(strong,nonatomic) NSMutableArray *channelList; //频道列表
@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _radius = 2;
    _channelList = [NSMutableArray array];
    _isShowed = NO;
    [self configLayout];
}

- (void) configLayout {
    [self.view setFrame:CGRectMake(-self.width-self.radius, GlobalDefine.HeaderHight, self.width, [GlobalDefine getBodyHeight])];
    //设置阴影
    self.view.layer.shadowColor = [UIColor grayColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(self.radius,0);
    self.view.layer.shadowOpacity = 0.7;
    self.view.layer.shadowRadius = self.radius;
    //设置毛玻璃效果
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.view.bounds;
    visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:visualEffectView];
    //设置频道展示table
    self.channelTable = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.channelTable.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.channelTable.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.channelTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.channelTable.backgroundColor = [UIColor clearColor];
    self.channelTable.scrollsToTop = false;
    self.channelTable.dataSource = self;
    self.channelTable.delegate = self;
//    self.channelTable.scrollEnabled = NO;
    [self.view addSubview:self.channelTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleChannelView {
    if (self.isShowed) {
        [self clolseChannelView];
    } else {
        [self showChannelView];
    }
}

- (void)showChannelView {
    self.isShowed = YES;
    [UIView animateWithDuration:0.4f animations:^(void){
        self.view.frame = CGRectMake(0, GlobalDefine.HeaderHight, self.width, [GlobalDefine getBodyHeight]);
    } completion:nil];
}

- (void)clolseChannelView {
    self.isShowed = NO;
    [UIView animateWithDuration:0.3f animations:^(void){
        self.view.frame = CGRectMake(-self.width-3, GlobalDefine.HeaderHight, self.width, [GlobalDefine getBodyHeight]);
    } completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.channelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    //设置单元格颜色及选中后的颜色
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    cell.selectedBackgroundView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    QCBChannelModel *channel = [self.channelList objectAtIndex:indexPath.row];
    cell.textLabel.text = channel.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self clolseChannelView];
    QCBChannelModel *channel = [self.channelList objectAtIndex:indexPath.row];
    NSLog(@"选择频道:%@,cid:%@",channel.name,channel.channel_id);
    MainViewController *superController = (MainViewController*)self.parentViewController;
    [superController closeShadeView];
    //请求歌曲列表信息
    [QCBBaseRequest songList:GlobalDefine.songUrl channelId:channel.channel_id type:@"n" success:^(NSArray *songList) {
        NSLog(@"获得%ld首歌曲",songList.count);
        [superController setChannelId:channel.channel_id];
        [superController removeAllSongs];
        [superController addSongs:songList];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view.superview addSubview:HUD];
        HUD.labelText = @"频道获取失败";
        HUD.mode = MBProgressHUDModeText;
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            [HUD removeFromSuperview];
        }];
    }];
    [self.channelTable deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态
}

- (void)addChannels:(NSArray *)channels {
    [self.channelList addObjectsFromArray:channels];
    [self.channelTable reloadData];
}

- (void)addChannel:(QCBChannelModel *)channel {
    [self.channelList addObject:channel];
    [self.channelTable reloadData];
}

- (void) removeAllChannels {
    [self.channelList removeAllObjects];
    [self.channelTable reloadData];
}

- (void)fireResize {
//    [UIView animateWithDuration:0.4f animations:^(void){
         [self.view setFrame:CGRectMake(-self.width-self.radius, GlobalDefine.HeaderHight, self.width, [GlobalDefine getBodyHeight])];
//    } completion:nil];
}
@end
