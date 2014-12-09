//
//  BBPlayerViewController.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/7.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "BBPlayerViewController.h"
#import "BBPlayerControlViewController.h"

@interface BBPlayerViewController ()<VLCMediaPlayerDelegate>


@end

@implementation BBPlayerViewController



#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _player = [[VLCMediaListPlayer alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    _player.mediaPlayer.drawable = self.view;
    _player.mediaPlayer.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

-(void)setVideoURL:(NSURL *)url{
    
    VLCMedia *media = [VLCMedia mediaWithURL:url];
    [_player setRootMedia:media];
}

-(void)setVideoListURL:(NSArray *)urls{
    VLCMediaList *mediaList = [[VLCMediaList alloc]init];
    
    for(NSString *url in urls)
    {
        VLCMedia *media = [VLCMedia mediaWithURL:[NSURL URLWithString:url]];
        [mediaList addMedia:media];
    }
    
    [_player setMediaList:mediaList];
    
}

-(void)play{
    [_player play];
}

-(void)mediaPlayerStateChanged:(NSNotification *)aNotification{
    VLCMediaPlayer *obj = aNotification.object;
    switch (obj.state) {
        case VLCMediaPlayerStateOpening:
            NSLog(@"打开中...");
            break;
        case VLCMediaPlayerStatePlaying:
            NSLog(@"播放中....");
            break;
        case VLCMediaPlayerStateBuffering:
            NSLog(@"缓存中....");
            break;
            
        default:
            break;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    BBPlayerControlViewController *control = [[BBPlayerControlViewController alloc]init];
    [control showPlayerControl:self];
    NSLog(@"touch");
}


@end
