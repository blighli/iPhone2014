//
//  PlayerController.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/22/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import "PlayerController.h"
@interface PlayerController(){
    AppDelegate* appDelegate;
    NetworkManager *networkManager;
}
@end
@implementation PlayerController
-(instancetype)init{
    if (self = [super init]) {
        appDelegate = [[UIApplication sharedApplication]delegate];
        networkManager = [[NetworkManager alloc]init];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(finishSongNormally)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:appDelegate.player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readyForDisplay) name: MPMoviePlayerLoadStateDidChangeNotification object:appDelegate.player];

    
    return self;
}

-(void)readyForDisplay{
    [self.pictureDelegate setPictureWithURLInString:appDelegate.currentSong.picture];
}

-(void)finishSongNormally{
    if (appDelegate.currentSongIndex >= ([appDelegate.playList count]-1)) {
        [networkManager loadPlaylistwithType:@"p" Sid:nil];
    }
    else{
        ++appDelegate.currentSongIndex;
        appDelegate.currentSong = [appDelegate.playList objectAtIndex:appDelegate.currentSongIndex];
        [appDelegate.player setContentURL:[NSURL URLWithString:[appDelegate.currentSong valueForKey:@"url"]]];
        [self.pictureDelegate setPictureWithURLInString:appDelegate.currentSong.picture];
        [appDelegate.player play];
        NSLog(@"SongIndex:%d",appDelegate.currentSong.index);
    }
}

//点击下一曲事件，按照豆瓣算法，需要重新载入播放列表
-(void)skipSong{
    [networkManager loadPlaylistwithType:@"s" Sid:appDelegate.currentSong.sid];
}

@end
