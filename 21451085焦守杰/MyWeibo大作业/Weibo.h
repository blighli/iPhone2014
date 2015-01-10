//
//  Weibo.h
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/3.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Comment.h"
#import "User.h"
@interface Weibo : NSObject<NSURLConnectionDataDelegate>{
  @private
    NSMutableData *_receiveData;
    BOOL *_success;
    User *_user;
    NSString *_finalPath;
   
}
@property(strong,nonatomic)NSString *finalPath;
@property(strong,nonatomic)User* user;
//@property (strong,nonatomic) NSString  *accessToken;
-(NSString* )getOauthAccessToken;
+(Weibo *)getInstance;
-(NSDictionary*)loadFriendWeibo:(NSString *)s;
-(UIImage *) loadUIImage:(NSString *)s;
-(void)postComment:(Comment *)comment;
-(void)updateWeibo:(NSString *)content;
-(NSDictionary *)getUserInfo;
-(NSMutableArray*)getComment:(NSString *)s;
@end
