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
    NetworkManager *networdManager;
}
@end
@implementation PlayerController
-(instancetype)init{
    if (self = [super init]) {
        appDelegate = [[UIApplication sharedApplication]delegate];
        networdManager = [[NetworkManager alloc]init];
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
    if (appDelegate.currentSong.index >= ([appDelegate.playList count]-1)) {
        [networdManager loadPlaylistwithType:@"n" Sid:nil];
    }
    else{
        ++appDelegate.currentSong.index;
        [self.pictureDelegate setPictureWithURLInString:appDelegate.currentSong.picture];
        [appDelegate.player setContentURL:[NSURL URLWithString:[[appDelegate.playList objectAtIndex:appDelegate.currentSong.index]valueForKey:@"url"]]];
        [self.pictureDelegate setPictureWithURLInString:appDelegate.currentSong.picture];
        [appDelegate.player play];
        NSLog(@"SongIndex:%d",appDelegate.currentSong.index);
    }
}

//点击下一曲事件，按照豆瓣算法，需要重新载入播放列表
-(void)skipSong{
    [networdManager loadPlaylistwithType:@"s" Sid:appDelegate.currentSong.sid];
}

@end
