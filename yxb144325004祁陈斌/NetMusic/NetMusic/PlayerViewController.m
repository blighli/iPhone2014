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
#import "MainViewController.h"
#import "MBProgressHUD.h"
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPMoviePlayerController.h>

@interface PlayerViewController()
@property(assign,nonatomic) NSInteger radius;
@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UILabel *songTitle;
@property(strong,nonatomic) UILabel *artistTitle;
@property(retain,nonatomic) NSData *albumImageData;
@property(strong,nonatomic) UIButton *toggleButton;
@property(strong,nonatomic) UIButton *skipButton;
@property(strong,nonatomic) UIView *progressBar;
@property(assign,nonatomic) BOOL isPlaying;
@property(assign,nonatomic) BOOL isPaused;//曾经被暂停
@property(strong,nonatomic) NSString* status;
@property(strong,nonatomic) NSURL *songUrl;
@property(strong,nonatomic) NSTimer *progressUpdateTimer;
@property(assign,nonatomic) double totalSongTimeSecond;//歌曲总时长
@property(assign,nonatomic) double currentSongTimeSecond;//当前歌曲时长
@property (nonatomic, retain) MPMoviePlayerController *audioPlayer;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _radius = 3;
    _isPlaying = NO;
    _isShowed = NO;
    _isPaused = NO;
    _currentSongTimeSecond = 0;
    _totalSongTimeSecond = 0;
    _audioPlayer = [[MPMoviePlayerController alloc] init];

    [self configPlayer];
    [self configLayout];
}

- (void) configPlayer {
    [[AVAudioSession sharedInstance] setDelegate: self];
    NSError *err;
    
    // Initialize the AVAudioSession here.
    if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&err]) {
        // Handle the error here.
        NSLog(@"Audio Session error %@, %@", err, [err userInfo]);
    }
    else{
        // Since there were no errors initializing the session, we'll allow begin receiving remote control events
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
    [_audioPlayer setShouldAutoplay:NO];
    [_audioPlayer setControlStyle: MPMovieControlStyleEmbedded];
    _audioPlayer.view.hidden = YES;
    [self.view addSubview:_audioPlayer.view];
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
    _audioPlayer.contentURL = self.songUrl;
    self.albumImageData = data;
    [self changeCenterSongInfo];
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

- (void) changeCenterSongInfo {
    
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    
    if (playingInfoCenter) {
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        [songInfo setObject:self.song.title forKey:MPMediaItemPropertyTitle];
        [songInfo setObject:self.song.artist forKey:MPMediaItemPropertyArtist];
        [songInfo setObject:self.song.albumtitle forKey:MPMediaItemPropertyAlbumTitle];
        [songInfo setObject:[[NSNumber alloc] initWithDouble:self.currentSongTimeSecond] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        [songInfo setObject:[[NSNumber alloc] initWithDouble:self.totalSongTimeSecond]  forKey:MPMediaItemPropertyPlaybackDuration];
//        if (self.albumImageData) {
//            MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:[[UIImage alloc] initWithData:self.albumImageData]];
//            [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
//        }
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
        
        
    }

}

- (void) playerToggle {
    if (self.isPlaying) {
        self.isPlaying = NO;
        [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStart"] forState:UIControlStateNormal];
        [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStart_prs"] forState:UIControlStateHighlighted];
        [self.audioPlayer pause];
        self.isPaused = YES;
    } else {
        self.isPlaying = YES;
        [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStop"] forState:UIControlStateNormal];
        [self.toggleButton setBackgroundImage:[UIImage imageNamed:@"mStop_prs"] forState:UIControlStateHighlighted];
        if (self.isPaused) {
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        } else {
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
            //实时修改进度条
            if (self.progressUpdateTimer) {
                [self.progressUpdateTimer invalidate];
                self.progressUpdateTimer = nil;
            }
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFinish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
            self.progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                        target:self
                                                                      selector:@selector(updatePlayerProgress)
                                                                      userInfo:nil
                                                                       repeats:YES];
        }
        
    }
}
//歌曲结束
- (void) playerFinish {
    if (self.totalSongTimeSecond > 0 && self.totalSongTimeSecond - self.currentSongTimeSecond <= 2) {
        NSLog(@"歌曲结束");
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        MainViewController* parentViewController = (MainViewController*) self.parentViewController;
        QCBSongModel *nextSong = [parentViewController getNextSong];
        [self stop];
        
        if (nextSong) {
            self.song = nextSong;
            [self play];
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

- (void) playBack {
    MainViewController* parentViewController = (MainViewController*) self.parentViewController;
    QCBSongModel *previousSong = [parentViewController getPreviousSong];
    if (previousSong) {
        [self stop];
        self.song = previousSong;
        [self play];
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
    if (self.audioPlayer.playbackState == MPMoviePlaybackStatePlaying ||
        self.audioPlayer.playbackState == MPMoviePlaybackStatePaused) {
        [self.audioPlayer stop];
    }
}

- (void) play {
    self.progressBar.frame = CGRectMake(-GlobalDefine.ScreenWidth, GlobalDefine.FooterHight-3, GlobalDefine.ScreenWidth, 3);
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:self.songUrl options:opts];  // 初始化媒体文件
    
    self.totalSongTimeSecond = urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒
    NSLog(@"总时长:%.0lf秒",self.totalSongTimeSecond);
    [self playerToggle];
}

- (void) updatePlayerProgress {
    
    NSTimeInterval cur = self.audioPlayer.currentPlaybackTime;
    double percent = 0;
    if (self.totalSongTimeSecond != 0) {
        percent = cur/self.totalSongTimeSecond;
        self.currentSongTimeSecond = cur;
        if (cur == self.totalSongTimeSecond) {
            if (self.progressUpdateTimer) {
                [self.progressUpdateTimer invalidate];
                self.progressUpdateTimer = nil;
            }
            
        }
    }
    self.progressBar.frame = CGRectMake(-(GlobalDefine.ScreenWidth*(1-percent)), GlobalDefine.FooterHight-3, GlobalDefine.ScreenWidth, 3);
    [self changeCenterSongInfo];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    [super viewDidDisappear:animated];
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    if ( receivedEvent.type == UIEventTypeRemoteControl ) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlPlay:
            case UIEventSubtypeRemoteControlPause:
            case UIEventSubtypeRemoteControlStop:
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self playerToggle];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self playBack];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                [self playerSkip];
                break;
            default:
                break;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
