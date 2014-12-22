//
//  PlayerController.h
//  ProjectFinal
//
//  Created by xvxvxxx on 12/22/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NetworkManager.h"

@protocol PlayerControllerDelegate <NSObject>
-(void)setPictureWithURLInString:(NSString *)url;
@end
@interface PlayerController : NSObject
@property id<PlayerControllerDelegate> pictureDelegate;
-(instancetype)init;
-(void)startPlay;
-(void)finishSongNormally;
-(void)skipSong;
@end
