//
//  HttpController.m
//  DoubanFM
//
//  Created by 陈聪荣 on 14/12/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "HttpController.h"

@implementation HttpController{
    NSString *channelUrl ;
    NSString *songUrl ;
}

- (instancetype) init{
    self = [super init];
    channelUrl = @"http://www.douban.com/j/app/radio/channels";
    songUrl = @"http://douban.fm/j/mine/playlist?from=mainsite&type=n&channel=";
    return self;
}

- (void) requestDouban:(NSString*)urlString withType:(NSString*)type AndNotificationName:(NSString*)name{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response , NSData * data , NSError *connectionError){
        NSError *jsonError;
        if ([data length] > 0 && connectionError == nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (json == nil) {
                NSLog(@"json parse failed!");
                return;
            }
           NSMutableArray *dataArrray = [json objectForKey:type];
            //NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
            [[NSNotificationCenter defaultCenter] postNotificationName:name object:dataArrray userInfo:nil];
        }else if ([data length] == 0 && connectionError == nil){
            NSLog(@"Nothing was in array.");
        }else if (connectionError != nil){
            NSLog(@"Error happened = %@",connectionError);
        }
    }];
}

-(NSMutableArray*) requestDoubanChannels{
    NSURL *url = [NSURL URLWithString:channelUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response , NSData * data , NSError *connectionError){
        NSError *jsonError;
        if ([data length] > 0 && connectionError == nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (json == nil) {
                NSLog(@"json parse failed!");
                return;
            }
            NSMutableArray *dataArrray = [json objectForKey:@"channels"];
            //NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadChannelView" object:dataArrray userInfo:nil];
        }else if ([data length] == 0 && connectionError == nil){
            NSLog(@"Nothing was in array.");
        }else if (connectionError != nil){
            NSLog(@"Error happened = %@",connectionError);
        }
    }];
    return  nil;
}

-(NSMutableArray*) requestDoubanSongsWithChannel:(NSInteger) channelId{
    
    NSMutableString *baseurl = [NSMutableString stringWithString:songUrl];
    [baseurl appendString:[NSString stringWithFormat:@"%d",(int)channelId]];
    NSURL *url = [NSURL URLWithString:baseurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response , NSData * data , NSError *connectionError){
        NSError *jsonError;
        if ([data length] > 0 && connectionError == nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (json == nil) {
                NSLog(@"json parse failed!");
                return;
            }
            NSMutableArray *dataArrray = [[NSMutableArray alloc]initWithArray:[json objectForKey:@"song"]];
            //将channel封装到数组中
            [dataArrray addObject:[NSNumber numberWithInt:(int)channelId]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadSongView" object:dataArrray userInfo:nil];
        }else if ([data length] == 0 && connectionError == nil){
            NSLog(@"Nothing was in array.");
        }else if (connectionError != nil){
            NSLog(@"Error happened = %@",connectionError);
        }
    }];
    return nil;
}

-(NSData*) requestSongImage:(NSString*) imageUrl{
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data=[NSURLConnection sendSynchronousRequest : request returningResponse:nil error:nil];
    return data;
}



-(void) download:(NSData*) data
{
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsDir stringByAppendingPathComponent:@"apple.html"];
    [data writeToFile:filePath atomically:YES];
    NSLog(@"Successfully saved the file to %@",filePath);
    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"HTML = %@",html);
}


-(void) foundation2json{
    NSDictionary *song = [NSDictionary dictionaryWithObjectsAndKeys:@"i can fly",@"title",@"4012",@"length",@"Tom",@"Singer", nil];
    if ([NSJSONSerialization isValidJSONObject:song])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:song options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json data:%@",json);
    }
}
@end
