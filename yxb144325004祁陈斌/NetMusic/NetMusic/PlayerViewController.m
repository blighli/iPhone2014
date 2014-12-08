//
//  PlayerViewController.m
//  NetMusic
//
//  Created by xsdlr on 14/12/6.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "PlayerViewController.h"
#include "GlobalDefine.h"
#import "QCBBaseRequest+SongRequest.h"
#import "UIButtonMake.h"
#import "FSAudioStream.h"
#import "FSAudioController.h"
#import "MainViewController.h"
#import "MBProgressHUD.h"

@interface PlayerViewController()
@property(assign,nonatomic) NSInteger radius;
@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UILabel *songTitle;
@property(strong,nonatomic) UILabel *artistTitle;
@property(strong,nonatomic) UIButton *toggleButton;
@property(strong,nonatomic) UIButton *skipButton;
@property(strong,nonatomic) UIView *progressBar;
@property(assign,nonatomic) BOOL isPlaying;
@property(assign,nonatomic) BOOL isPaused;//曾经被暂停
@property(strong,nonatomic) NSString* status;
@property(strong,nonatomic) FSAudioController *audioController;
@property(strong,nonatomic) NSURL *songUrl;
@property(strong,nonatomic) NSTimer *progressUpdateTimer;
@property(assign,nonatomic) double percent;//播放进度
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _radius = 3;
    _isPlaying = NO;
    _isShowed = NO;
    _isPaused = NO;
    _percent = 0;
    _audioController = [[FSAudioController alloc] init];
    [self configLayout];
}

- (void) configLayout {
    self.view.frame = CGRectMake(0, GlobalDefine.ScreenHeight, GlobalDefine.ScreenWidth, GlobalDefine.FooterHight);
    
    //设置阴影
    self.view.layer.shadowColor = [UIColor grayColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0,-self.radius);
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
    //设置图片显示区域
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, GlobalDefine.FooterHight, GlobalDefine.FooterHight)];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.imageView];
    //设置歌曲信息view
    self.songTitle = [[UILabel alloc]initWithFrame:CGRectMake(GlobalDefine.FooterHight+5, 10, GlobalDefine.ScreenWidth-3*GlobalDefine.FooterHight, 20)];
    self.songTitle.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:self.songTitle];
    self.artistTitle = [[UILabel alloc]initWithFrame:CGRectMake(GlobalDefine.FooterHight+5, 30, GlobalDefine.ScreenWidth-3*GlobalDefine.FooterHight, 20)];
    self.artistTitle.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:self.artistTitle];
    //设置播放按钮
    self.toggleButton = [UIButtonMake createWithImage:[UIImage imageNamed:@"mStart"]
                                        selectedimage:[UIImage imageNamed:@"mStart_prs"]
                                                frame:CGRectMake(GlobalDefine.ScreenWidth-2*GlobalDefine.FooterHight, 0, GlobalDefine.FooterHight, GlobalDefine.FooterHight)
                                               target:self
                                               action:@selector(playerToggle)
                                               events:UIControlEventTouchUpInside];
    self.skipButton = [UIButtonMake createWithImage:[UIImage imageNamed:@"mSkip"]
                                        selectedimage:[UIImage imageNamed:@"mSkip_prs"]
                                                frame:CGRectMake(GlobalDefine.ScreenWidth-GlobalDefine.FooterHight, 0, GlobalDefine.FooterHight, GlobalDefine.FooterHight)
                                               target:self
                                               action:@selector(playerSkip)
                                               events:UIControlEventTouchUpInside];
    [self.view addSubview:self.toggleButton];
    [self.view addSubview:self.skipButton];
    //设置进度条
    self.progressBar = [[UIView alloc]initWithFrame:CGRectMake(-GlobalDefine.ScreenWidth, GlobalDefine.FooterHight-3, GlobalDefine.ScreenWidth, 3)];
    self.progressBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.progressBar];
    
}

- (void) setSong:(QCBSongModel *)song {
    [self showPlayer];
    _song = song;
    NSString *sid = song.sid;
    NSLog(@"sid:%@",sid);
    self.songTitle.text = song.title;
    self.artistTitle.text = song.artist;
    //读取专辑图片
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL* filePathUrl = [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",sid]];
    NSData *data = [[NSData alloc]initWithContentsOfURL:filePathUrl];
    
    self.songUrl = [[NSURL alloc]initWithString:song.url];
    self.audioController.url = self.songUrl;
    
    if (data) {
        self.imageView.image = [[UIImage alloc] initWithData:data];
    } else {
        [QCBBaseRequest downloadSongCoverPic:song.picture rename:[NSString stringWithFormat:@"%@.jpg",sid] success:^(NSURL *filePath) {
            NSData *data = [[NSData alloc]initWithContentsOfURL:filePath];
            self.imageView.image = [[UIImage alloc] initWithData:data];
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
            MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view.superview addSubview:HUD];
            HUD.labelText = @"图片获取失败";
            HUD.mode = MBProgressHUDModeText;
            [HUD showAnimated:YES whileExecutingBlock:^{
                sleep(2);
            } completionBlock:^{
                [HUD removeFromSuperview];
            }];
        }];
    }
}

- (void) playerToggle {
    if (self.isPlaying) {
        self.isPlaying = NO;
        [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStart"] forState:UIControlStateNormal];
        [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStart_prs"] forState:UIControlStateHighlighted];
        [self.audioController pause];
        self.isPaused = YES;
    } else {
        self.isPlaying = YES;
        [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStop"] forState:UIControlStateNormal];
        [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStop_prs"] forState:UIControlStateHighlighted];
        if (self.isPaused) {
            [self.audioController pause];
        } else {
            if (self.progressUpdateTimer) {
                [self.progressUpdateTimer invalidate];
                self.progressUpdateTimer = nil;
            }
            //实时修改进度条
            if (self.progressUpdateTimer) {
                [self.progressUpdateTimer invalidate];
                self.progressUpdateTimer = nil;
            }
            self.progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                        target:self
                                                                      selector:@selector(updatePlayerProgress)
                                                                      userInfo:nil
                                                                       repeats:YES];
            
            [self.audioController play];
            
//            self.audioController.stream.onStateChange = ^(FSAudioStreamState state) {
//                if (state == kFSAudioStreamEndOfFile) {
//                    NSLog(@"test");
//                }
//            };
            self.audioController.stream.onCompletion = ^(){
                self.isPlaying = NO;
                self.isPaused = NO;
                [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStart"] forState:UIControlStateNormal];
                [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStart_prs"] forState:UIControlStateHighlighted];
                [self.audioController stop];
                if (self.progressUpdateTimer) {
                    [self.progressUpdateTimer invalidate];
                    self.progressUpdateTimer = nil;
                }
                MainViewController* parentViewController = (MainViewController*) self.parentViewController;
                QCBSongModel *nextSong = [parentViewController getNextSong];
                if (nextSong) {
                    [self stop];
                    self.song = nextSong;
                    [self play];
                } else {
                    self.audioController.url = self.songUrl;
                }
            };
        }
        
    }
}

- (void) playerSkip {
    MainViewController* parentViewController = (MainViewController*) self.parentViewController;
    QCBSongModel *nextSong = [parentViewController getNextSong];
    if (nextSong) {
        [self stop];
        self.song = nextSong;
        [self play];
    } else {
        MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view.superview addSubview:HUD];
        HUD.labelText = @"歌单已播完";
        HUD.mode = MBProgressHUDModeText;
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            [HUD removeFromSuperview];
        }];
    }
}

- (void) showPlayer {
    self.isShowed = YES;
    [UIView animateWithDuration:0.4f animations:^(void){
        self.view.frame = CGRectMake(0, GlobalDefine.ScreenHeight-GlobalDefine.FooterHight, GlobalDefine.ScreenWidth, GlobalDefine.FooterHight);
    } completion:nil];
}

- (void) stop {
    self.isPlaying = NO;
    self.isPaused = NO;
    if (self.audioController.isPlaying) {
        [self.audioController stop];
    }
}

- (void) play {
    self.progressBar.frame = CGRectMake(-GlobalDefine.ScreenWidth, GlobalDefine.FooterHight-3, GlobalDefine.ScreenWidth, 3);
    [self playerToggle];
}

- (void) updatePlayerProgress {
    FSStreamPosition cur = self.audioController.stream.currentTimePlayed;
    FSStreamPosition end = self.audioController.stream.duration;

    double newPercent = 0;
    if ((end.minute*60 + end.second) > 0) {
        newPercent = 1.0 * (cur.minute*60 + cur.second) / (end.minute*60 + end.second);
    }
    //修复AudioSession释放不完全bug
    if (newPercent == _percent && newPercent != 0 && newPercent != 1) {
        [self.audioController pause];
        [self.audioController pause];
    } else {
        _percent = newPercent;
    }
    
    self.progressBar.frame = CGRectMake(-(GlobalDefine.ScreenWidth*(1-newPercent)), GlobalDefine.FooterHight-3, GlobalDefine.ScreenWidth, 3);
}
@end
