//
//  MainViewController.m
//  NetMusic
//
//  Created by xsdlr on 14/12/1.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ChannelViewController.h"
#include "GlobalDefine.h"
#import "QCBChannelModel.h"
#import "QCBBaseRequest+ChannelRequest.h"
#import "QCBBaseRequest+SongRequest.h"
#import "PlayerViewController.h"

@interface MainViewController ()
@property(strong,nonatomic) ChannelViewController *channelViewController;
@property(strong,nonatomic) SongTableViewController *songTableViewController;
@property(strong,nonatomic) PlayerViewController * playerViewController;
@property(strong,nonatomic) ShadeView *shadeView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GlobalDefine setBodyHeight:GlobalDefine.ScreenHeight - GlobalDefine.HeaderHight];
    [self configLayout];        //配置主界面
    [self configSongTable];
    [self configLeftSideMenu];  //配置左边栏
    [self configPlayView];
    [self loadChannelData];     //加载频道数据
    [self loadSongData];        //初始化加载默认频道歌曲
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) leftButtonDealer: (id)sender {
    if (self.channelViewController.isShowed) {
        [self.shadeView removeFromSuperview];
    } else {
        [self addShadeView];
    }
    [self.channelViewController toggleChannelView];
}

- (void) configLeftSideMenu {
    self.channelViewController = [ChannelViewController new];
//    self.channelViewController.delegate = self;
    UIView *leftView = self.channelViewController.view;
    [self.view insertSubview:leftView atIndex:2];
    self.channelViewController.width = 150.0f;//设置边栏的宽度
    [self addChildViewController:self.channelViewController];

}

- (void) configSongTable {
    self.songTableViewController = [SongTableViewController new];
    [self addChildViewController:self.songTableViewController];
    [self.view insertSubview:self.songTableViewController.view atIndex:0];
}

- (void) configPlayView {
    self.playerViewController = [PlayerViewController new];
    UIView *playerView = self.playerViewController.view;
    [self.view insertSubview:playerView atIndex:2];
    [self addChildViewController:self.playerViewController];
}

- (void) configLayout {
    self.navigationBarTitleColor = [UIColor colorWithRed:0.718 green:0.117 blue:0.156 alpha:0.800];
    [self addTitleViewByTitle:@"音乐" color: [UIColor whiteColor]];
    [self addLeftButtonByImage:@"menu" selectedImageName:@"menu_prs"];
}

- (void) addShadeView {
    self.shadeView = [[ShadeView alloc]initWithFrame:CGRectMake(0, GlobalDefine.HeaderHight, GlobalDefine.ScreenWidth, GlobalDefine.ScreenHeight-GlobalDefine.HeaderHight)];
    self.shadeView.delegate = self;
    self.shadeView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:self.shadeView aboveSubview:self.songTableViewController.view];
}

- (void) qTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.channelViewController.isShowed) {
        [self closeShadeView];
        [self.channelViewController toggleChannelView];
    }
}

- (void) loadChannelData {
    [QCBBaseRequest channelList:GlobalDefine.channelUrl success:^(NSArray *channelList) {
        NSLog(@"频道数据加载成功");
        [self.channelViewController addChannels: channelList];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void) loadSongData {
    [QCBBaseRequest songList:GlobalDefine.songUrl channelId:@"0" type:@"n" success:^(NSArray *songList) {
        NSLog(@"初始化歌曲数据加载成功");
        self.songTableViewController.channelId = @"0";
        [self.songTableViewController addSongs: songList];
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)closeShadeView {
    [self.shadeView removeFromSuperview];
}

- (void)addSong:(QCBSongModel *)song {
    [self.songTableViewController addSong:song];
}

- (void)addSongs:(NSArray *)songs {
    [self.songTableViewController addSongs:songs];
}

- (void)removeAllSongs {
    [self.songTableViewController removeAllSongs];
}

- (void)setChannelId:(NSString*) cid {
    self.songTableViewController.channelId = [cid copy];
}

- (void)playSong:(QCBSongModel *)song {
    //通知界面改变
    if (!self.playerViewController.isShowed) {
        [GlobalDefine setBodyHeight:GlobalDefine.ScreenHeight - GlobalDefine.HeaderHight - GlobalDefine.FooterHight];
        [self.playerViewController showPlayer];
        [self.songTableViewController fireResize];
        [self.channelViewController fireResize];
    }
    [self.playerViewController stop];
    [self.playerViewController setSong:song];
    [self.playerViewController play];
}

- (QCBSongModel *)getNextSong {
    NSUInteger index = self.songTableViewController.songIndex + 1;
    QCBSongModel *song = [self.songTableViewController getSongByIndex:index];
    if (song) {
        [self.songTableViewController selectRowAtIndex:index];
        self.songTableViewController.songIndex  = index;
    }
    return song;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
