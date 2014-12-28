//
//  NetworkManager.h
//  ProjectFinal
//
//  Created by xvxvxxx on 12/18/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "AppDelegate.h"
#import "SongInfo.h"
@protocol NetworManagerDelegate <NSObject>
-(void)setCaptchaImageWithURLInString:(NSString *)url;
@end

@interface NetworkManager : NSObject
@property id<NetworManagerDelegate>captchaImageDelegate;
@property NSMutableString *captchaID;

-(instancetype)init;
-(void)LoginwithUsername:(NSString *)username Password:(NSString *)password  Captcha:(NSString *)captcha RememberOnorOff:(NSString *)rememberOnorOff;
-(void)loadCaptchaImage;
-(void)loadPlaylistwithType:(NSString *)type;
@end
