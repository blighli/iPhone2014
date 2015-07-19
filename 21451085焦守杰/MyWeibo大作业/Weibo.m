//
//  Weibo.m
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/3.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "Weibo.h"
#import <UIKit/UIKit.h>
#import "Comment.h"
#define commentUrl @"https://api.weibo.com/2/comments/create.json"
#define updateWeiboUrl @"https://api.weibo.com/2/statuses/update.json"
#define getUserInfoUrl @"https://api.weibo.com/2/users/show.json"
#define getCommentUrl @"https://api.weibo.com/2/comments/show.json"
@implementation Weibo
//@synthesize accessToken;
static Weibo *_weibo;
-(NSString *)getOauthAccessToken{
    return nil;
}

+(Weibo *)getInstance{
    if(_weibo==nil){
        _weibo=[[Weibo alloc]init];
    }
    return _weibo;
}

-(id)init{
    if(self=[super init]){
        _receiveData=[[NSMutableData alloc]init];
        NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        self.finalPath=[documentDirectory stringByAppendingPathComponent:@"data.plist"];
        NSDictionary *d=[NSDictionary dictionaryWithContentsOfFile:self.finalPath];
        self->_user=[[User alloc]init];
        _user.token=[d objectForKey:@"access_token"];
        _user.UID=[d objectForKey:@"uid"];
//        _success=NO;
    }
    return self;
}
-(NSDictionary*)loadFriendWeibo:(NSString *)s{
    NSURL *url = [NSURL URLWithString:s];
//    NSLog(@"%@",url);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:50];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@",dictionary);
    return dictionary;
}
-(UIImage *) loadUIImage:(NSString *)s{
 //   NSLog(@"%@",s);
    UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:s]]];
    return image;
}
-(NSMutableArray*)getComment:(NSString *)id{
    NSString *s=[NSString stringWithFormat:@"%@?count=%d&access_token=%@&id=%@",getCommentUrl,20,self.user.token,id];
    NSURL *url=[NSURL URLWithString:s];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:50];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dictionary);
    return (NSMutableArray*)[dictionary objectForKey:@"comments"];

    
}


-(void)postComment:(Comment *)comment{
    NSString *s=[NSString stringWithFormat:@"%@?comment=%@&id=%@&access_token=%@",commentUrl,comment.comment,comment.id,self.user.token];
    [self post:s];
}

-(void)updateWeibo:(NSString *)content{
    NSString *s=[NSString stringWithFormat:@"%@?status=%@&access_token=%@",updateWeiboUrl,content,self.user.token];
    [self post:s];
}

-(NSDictionary *)getUserInfo{
    NSString *s=[NSString stringWithFormat:@"%@?access_token=%@&uid=%@",getUserInfoUrl,self.user.token,self.user.UID];
    NSURL *url=[NSURL URLWithString:s];
    //    NSLog(@"%@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSData *receive=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSLog(@"%@",receive);
    return [NSJSONSerialization JSONObjectWithData:receive options:NSJSONReadingMutableContainers error:nil];
}
-(void)get:(NSString *)s{
   
}
-(void)post:(NSString *)s{
    NSURL *url=[NSURL URLWithString:s];
//    NSLog(@"%@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSData *receive=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1 = [[NSString alloc]initWithData:receive encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str1);
}

@end
