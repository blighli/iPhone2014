//
//  NetworkManager.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/18/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
@interface NetworkManager(){
    AppDelegate *appDelegate;
    AFHTTPRequestOperationManager *manager;
}
@end
@implementation NetworkManager
-(instancetype)init{
    if (self = [super init]) {
        appDelegate = [[UIApplication sharedApplication]delegate];
        manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

//登陆数据格式
//POST Params:
//remember:on/off
//source:radio
//captcha_solution:cheese 验证码
//alias:xxxx%40gmail.com
//form_password:password
//captcha_id:jOtEZsPFiDVRR9ldW3ELsy57%3en
-(void)LoginwithUsername:(NSString *)username Password:(NSString *)password CaptchaID:(NSString *)captchaID Captcha:(NSString *)captcha RememberOnorOff:(NSString *)rememberOnorOff{
    NSDictionary *loginParameters = @{@"remember": rememberOnorOff,
                                      @"source": @"radio",
                                      @"captcha_solution": captcha,
                                      @"alias": username,
                                      @"form_password":password,
                                      @"captcha_id":captchaID};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *loginURL = @"http://douban.fm/j/login";
    //        NSMutableArray *allTracks = [NSMutableArray array];
    [manager POST:loginURL parameters:loginParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"json:%@",responseObject);
        NSString *msg = [responseObject objectForKey:@"err_msg"];
        NSLog(@"%@",msg);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"0");
    }];
}

//获取播放列表信息
//type
//n : None. Used for get a song list only.
//e : Ended a song normally.
//u : Unlike a hearted song.
//r : Like a song.
//s : Skip a song.
//b : Trash a song.
//p : Use to get a song list when the song in playlist was all played.

//sid
//the song's id
-(void)loadPlaylistwithType:(NSString *)type Sid:(NSString *)sid{
    NSString *playlistURL;
    if (sid == nil) {
        playlistURL = [NSString stringWithFormat:@"http://douban.fm/j/mine/playlist?type=%@&channel=%@&from=mainsite",type,appDelegate.currentChannel.ID];
    }
    else{
        playlistURL = [NSString stringWithFormat:@"http://douban.fm/j/mine/playlist?type=%@&sid=%@&channel=%@&from=mainsite",type,sid,appDelegate.currentChannel.ID];
    }
    [appDelegate.playList removeAllObjects];
    NSString *playlistUrl = @"http://douban.fm";
    playlistUrl = [playlistUrl stringByAppendingString:@"/j/mine/playlist?type=s&sid=1395079&pt=3.3&channel=0&pb=64&from=mainsite&r=41c64da174"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:playlistUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *songDictionary = responseObject;
        NSLog(@"JSON: %@", songDictionary);
        int index = 0;
        for (NSDictionary *song in [songDictionary objectForKey:@"song"]) {
            //subtype=T为广告标识位，如果是T，则不加入播放列表(去广告)
            if ([[song objectForKey:@"subtype"] isEqualToString:@"T"]) {
                continue;
            }
            SongInfo *tempSong = [[SongInfo alloc] init];
            [tempSong setIndex:index];
            [tempSong setArtist:[song objectForKey:@"artist"]];
            [tempSong setTitle:[song objectForKey:@"title"]];
            [tempSong setUrl:[song objectForKey:@"url"]];
            [tempSong setPicture:[song objectForKey:@"picture"]];
            [tempSong setLength:[song objectForKey:@"length"]];
            [tempSong setLike:[song objectForKey:@"like"]];
            [tempSong setSid:[song objectForKey:@"sid"]];
            [appDelegate.playList addObject:tempSong];
            ++index;
        }
        [appDelegate.player setContentURL:[NSURL URLWithString:[[appDelegate.playList objectAtIndex:0]valueForKey:@"url"]]];
        appDelegate.currentSong.index  = 0;
        NSLog(@"SongIndex:%d",appDelegate.currentSong.index);
        [appDelegate.player play];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}



//验证码图片点击刷新验证码事件
-(void)loadCaptchaImage{
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *captchaIDURL = @"http://douban.fm/j/new_captcha";
    [manager GET:captchaIDURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableString *tempCaptchaID = [[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [tempCaptchaID replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempCaptchaID length])];
        NSLog(@"%@",tempCaptchaID);
        NSString *chatchaURL = [NSString stringWithFormat:@"http://douban.fm/misc/captcha?size=m&id=%@",tempCaptchaID];
        //加载验证码图片
        [self.CaptchaImageDelegate setCaptchaImageWithURLInString:chatchaURL];
        //[self.imageview setImageWithURL:[NSURL URLWithString:chatchaURL]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
