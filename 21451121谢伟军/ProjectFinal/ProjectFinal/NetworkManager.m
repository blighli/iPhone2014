//
//  NetworkManager.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/18/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
static NSMutableString *captchaID;
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

//设置播放列表
-(void)setChannel:(NSUInteger)channelIndex withURLWithString:(NSString *)urlWithString{
    [manager GET:urlWithString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[appDelegate.channels objectAtIndex:channelIndex]removeAllObjects];
        NSDictionary *channelsDictionary = responseObject;
        NSLog(@"JSON: %@", channelsDictionary);
        NSDictionary *tempChannel = [channelsDictionary objectForKey:@"data"];
        if (channelIndex != 1) {
            for (NSDictionary *channels in [tempChannel objectForKey:@"channels"]) {
                ChannelInfo *channelInfo = [[ChannelInfo alloc]init];
                [channelInfo setID:[channels objectForKey:@"id"]];
                [channelInfo setName:[channels objectForKey:@"name"]];
                [[appDelegate.channels objectAtIndex:channelIndex] addObject:channelInfo];
            }
        }
        else{
            NSDictionary *channels = [tempChannel objectForKey:@"res"];
            if ([[channels allKeys]containsObject:@"rec_chls"]) {
                for (NSDictionary *tempRecCannels in [channels objectForKey:@"rec_chls"]) {
                    ChannelInfo *channelInfo = [[ChannelInfo alloc]init];
                    [channelInfo setID:[tempRecCannels objectForKey:@"id"]];
                    [channelInfo setName:[tempRecCannels objectForKey:@"name"]];
                    [[appDelegate.channels objectAtIndex:channelIndex] addObject:channelInfo];
                }
            }
            else{
                NSDictionary *channels = [tempChannel objectForKey:@"res"];
                ChannelInfo *channelInfo = [[ChannelInfo alloc]init];
                [channelInfo setID:[channels objectForKey:@"id"]];
                [channelInfo setName:[channels objectForKey:@"name"]];
                [[appDelegate.channels objectAtIndex:channelIndex] addObject:channelInfo];
            }
            
        }
        [self.delegate reloadTableviewData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


//登陆数据格式
//POST Params:
//remember:on/off
//source:radio
//captcha_solution:cheese 验证码
//alias:xxxx%40gmail.com
//form_password:password
//captcha_id:jOtEZsPFiDVRR9ldW3ELsy57%3en
-(void)LoginwithUsername:(NSString *)username Password:(NSString *)password  Captcha:(NSString *)captcha RememberOnorOff:(NSString *)rememberOnorOff{
//    NSDictionary *loginParameters = @{@"remember": rememberOnorOff,
//                                      @"source": @"radio",
//                                      @"captcha_solution": captcha,
//                                      @"alias": username,
//                                      @"form_password":password,
//                                      @"captcha_id":captchaID};
    NSDictionary *loginParameters = @{@"remember": rememberOnorOff,
                                      @"source": @"radio",
                                      @"captcha_solution": captcha,
                                      @"alias": @"373203339@qq.com",
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
        NSLog(@"LOGIN ERROR:%@",error);
    }];
}

-(void)Logout{
    
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
//sid : the song's id
-(void)loadPlaylistwithType:(NSString *)type{
    NSString *playlistURL = [NSString stringWithFormat:@"http://douban.fm/j/mine/playlist?type=%@&sid=%@&pt=%f&channel=%@&from=mainsite",type,appDelegate.currentSong.sid,appDelegate.player.currentPlaybackTime,appDelegate.currentChannel.ID];
    [appDelegate.playList removeAllObjects];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:playlistURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *songDictionary = responseObject;
        NSLog(@"JSON: %@", songDictionary);
        for (NSDictionary *song in [songDictionary objectForKey:@"song"]) {
            //subtype=T为广告标识位，如果是T，则不加入播放列表(去广告)
            if ([[song objectForKey:@"subtype"] isEqualToString:@"T"]) {
                continue;
            }
            SongInfo *tempSong = [[SongInfo alloc] init];
            tempSong.artist = [song objectForKey:@"artist"];
            tempSong.title = [song objectForKey:@"title"];
            tempSong.url = [song objectForKey:@"url"];
            tempSong.picture = [song objectForKey:@"picture"];
            tempSong.length = [song objectForKey:@"length"];
            tempSong.like = [song objectForKey:@"like"];
            tempSong.sid = [song objectForKey:@"sid"];
            [appDelegate.playList addObject:tempSong];
        }
        if ([type isEqualToString:@"r"]) {
            appDelegate.currentSongIndex = -1;
        }
        else{
            appDelegate.currentSongIndex = 0;
            appDelegate.currentSong = [appDelegate.playList objectAtIndex:appDelegate.currentSongIndex];
            [appDelegate.player setContentURL:[NSURL URLWithString:appDelegate.currentSong.url]];
            NSLog(@"SongIndex:%d",appDelegate.currentSong.index);
            [appDelegate.player play];
        }
        [self.delegate reloadTableviewData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}



//验证码图片
-(void)loadCaptchaImage{
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *captchaIDURL = @"http://douban.fm/j/new_captcha";
    [manager GET:captchaIDURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableString *tempCaptchaID = [[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [tempCaptchaID replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempCaptchaID length])];
        captchaID = tempCaptchaID;
        NSLog(@"%@",captchaID);
        NSString *chatchaURL = [NSString stringWithFormat:@"http://douban.fm/misc/captcha?size=m&id=%@",tempCaptchaID];
        //加载验证码图片
        [self.delegate setCaptchaImageWithURLInString:chatchaURL];
        //[self.imageview setImageWithURL:[NSURL URLWithString:chatchaURL]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}



@end
