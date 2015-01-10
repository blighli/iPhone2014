//
//  publicTimeLineApi.m
//  weiBo
//
//  Created by lixu on 14/12/6.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import "webServiceApi.h"
#import "publicLineParse.h"

@implementation webServiceApi
@synthesize token,userID;

-(NSArray *) readURL:(NSString *) urlString{
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy   timeoutInterval:60];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *array=[publicLineParse publicLineFromData:data];
    return array;
}

-(void) readToken{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsD=[path objectAtIndex:0];
    NSString *userFile=[documentsD stringByAppendingString:@"User.plist"];
    NSMutableDictionary *userD=[[NSMutableDictionary alloc] initWithContentsOfFile:userFile];
    token=[userD objectForKey:@"token"];
    userID=[userD objectForKey:@"uid"];
}

-(NSArray *) requestForPublicTimeLinePageCount:(NSInteger) pageCount{
    [self readToken];
    NSString *string=[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/public_timeline.json?access_token=%@&count=%ld",token,(long)pageCount];
    return  [self readURL:string];

}

-(NSArray *) requestForFriendTimeLineLoadPage:(NSInteger)page andPageCount:(NSInteger)pageCount {
    [self readToken];
    NSString *string=[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/friends_timeline.json?access_token=%@&page=%ld&count=%ld",token,(long)page,(long)pageCount];
    return [self readURL:string];
}

-(NSArray *) requestForMineTimeLineLoadPage:(NSInteger)page andPageCount:(NSInteger)pageCount{
    [self readToken];
    NSString *string=[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/user_timeline.json?access_token=%@&uid=%@&page=%ld&count=%ld",token,userID,page,pageCount];
    return [self readURL:string];
}

-(NSArray *) requestForHerTimeLineWithScreenName:(NSString *)name andPage:(NSInteger)page andPageCount:(NSInteger)pageCount{
    [self readToken];
    NSString *string=[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/user_timeline.json?access_token=%@&page=%ld&count=%ld&screen_name=%@",token,page,pageCount,name];
    return [self readURL:string];
}

-(void) updateMyNews:(NSString *)string{
    [self readToken];
    NSString *status=[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"status=%@",status);
    NSString *uString=[NSString stringWithFormat: @"https://api.weibo.com/2/statuses/update.json?access_token=%@&stutas=%@",token,status];
    NSLog(@"%@",uString);
    NSURL *url=[NSURL URLWithString:uString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
    NSString *text=[dic objectForKey:@"text"];
    NSLog(@"++++++++%@+++++++++++",text);
    
}


@end
