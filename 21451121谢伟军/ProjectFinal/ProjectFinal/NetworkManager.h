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
-(void)setPictureWithURLInString:(NSString *)url;
@end

@interface NetworkManager : NSObject
@property id<NetworManagerDelegate>CaptchaImageDelegate;
@property NSMutableString *captchaID;

-(instancetype)init;
-(void)LoginwithUsername:(NSString *)username Password:(NSString *)password CaptchaID:(NSString *)captchaID Captcha:(NSString *)captcha RememberOnorOff:(NSString *)rememberOnorOff;
-(void)loadCaptchaImage;
-(void)loadPlaylistwithType:(NSString *)type Sid:(NSString *)sid;
@end
