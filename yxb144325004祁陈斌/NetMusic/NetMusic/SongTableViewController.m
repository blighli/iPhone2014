//
//  SongTableViewController.m
//  NetMusic
//
//  Created by xsdlr on 14/12/6.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "SongTableViewController.h"
#include "GlobalDefine.h"
#import "QCBBaseRequest+SongRequest.h"
#import "MainViewController.h"
#import "MBProgressHUD.h"

@interface SongTableViewController()
@property(strong,nonatomic) NSMutableArray *songList;//歌曲信息列表
@end

@implementation SongTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _songList = [NSMutableArray array];
    _songIndex = NSUIntegerMax;//初始未选择
    UITableView *view = [[UITableView alloc]initWithFrame:CGRectMake(0, GlobalDefine.HeaderHight, GlobalDefine.ScreenWidth, [GlobalDefine getBodyHeight]) style:UITableViewStylePlain];
    view.separatorStyle = UITableViewCellSeparatorStyleNone;
    view.delegate = self;
    view.dataSource = self;
    self.view = view;
    self.tableView = view;
    //设置内部下拉刷新
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    refresh.tintColor = [UIColor blueColor];
    [refresh addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    //设置单元格颜色及选中后的颜色
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    cell.selectedBackgroundView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    QCBSongModel *song= [self.songList objectAtIndex:indexPath.row];
    cell.textLabel.text = song.title;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@ - %@",song.artist,song.albumtitle];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QCBSongModel *song = [self.songList objectAtIndex:indexPath.row];
    self.songIndex = indexPath.row;
//    NSLog(@"%ld",self.songIndex);
    MainViewController *parentController = (MainViewController*)self.parentViewController;
    [parentController playSong: song];
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态
//    NSLog(@"%@,%@-%@",song.title,song.artist,song.albumtitle);
}

- (void)addSong:(QCBSongModel *)song {
    [self.songList addObject:song];
    [self.tableView reloadData];
}

- (void)addSongs:(NSArray *)songs {
    [self.songList addObjectsFromArray:songs];
    [self.tableView reloadData];
}

- (void)removeAllSongs {
    [self.songList removeAllObjects];
    [self.tableView reloadData];
}

- (void) pullToRefresh {
    if (self.channelId) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
        //请求歌曲列表信息
        [QCBBaseRequest songList:GlobalDefine.songUrl channelId:self.channelId type:@"n" success:^(NSArray *songList) {
            [self.refreshControl endRefreshing];
            self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
            NSLog(@"获得%ld首歌曲",songList.count);
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0,[songList count])];
            [self.songList insertObjects:songList atIndexes:indexes];
            [self.tableView reloadData];
            if (self.songIndex != NSUIntegerMax) {
                self.songIndex += songList.count;
            }
            [self selectRowAtIndex:self.songIndex];//重新选中刷新前的行
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
            [self.refreshControl endRefreshing];
            self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        }];
    } else {
         [self.refreshControl endRefreshing];
        MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view.superview addSubview:HUD];
        HUD.labelText = @"请先选择频道";
        HUD.mode = MBProgressHUDModeText;
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            [HUD removeFromSuperview];
        }];
    }
}

- (void)fireResize {
    [UIView animateWithDuration:0.4f animations:^(void){
        self.view.frame = CGRectMake(0, GlobalDefine.HeaderHight, GlobalDefine.ScreenWidth, [GlobalDefine getBodyHeight]);
    } completion:nil];
}

- (QCBSongModel *)getSongByIndex:(NSUInteger)index {
    if (index < self.songList.count) {
        return [self.songList objectAtIndex:index];
    } else {
        return nil;
    }
}

- (void)selectRowAtIndex:(NSUInteger)index {
    if (index < self.songList.count) {
        NSIndexPath *cellPath=[NSIndexPath indexPathForItem:index inSection:0];
        [self.tableView selectRowAtIndexPath:cellPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}
@end
