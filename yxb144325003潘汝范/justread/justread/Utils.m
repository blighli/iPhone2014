//
//  Utils.m
//  justread
//
//  Created by Van on 14/12/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "Utils.h"
#import <Foundation/Foundation.h>

@implementation Utils

#pragma mark  get all data from FavStories
- (NSMutableArray *) getResult:(NSManagedObjectContext *)managedObjectContext
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FavStories"inManagedObjectContext:managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    return mutableFetchResult;
}
#pragma mark convert  hexadecimal number  to UIColor
- (UIColor *) stringToColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}
#pragma mark check many data in database
- (BOOL) serachWith:(Stories *) stories and:(NSManagedObjectContext *) managedObjectContext{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"FavStories"inManagedObjectContext:managedObjectContext]];
    NSNumber *id = stories.id;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id==%@", id]];
    NSError* error = nil;
    NSArray* results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0) {
        return YES;
    }else{
        return NO;
    }
    
}
#pragma mark share to wechat
- (Boolean) shareToWechatwith :(NSString *)title
                          with:(NSString *)description
                          with:(NSString *)shareUrl
                          with:(BOOL)isSendToTimeline{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        if (isSendToTimeline) {
            _scene=WXSceneTimeline;
        }
        else{
            _scene=WXSceneSession;
        }
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = description;
        [message setThumbImage:[UIImage imageNamed:@"icon80.png"]];
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = shareUrl;
        message.mediaObject = ext;
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene =_scene;
        
        [WXApi sendReq:req];
        return YES;
    }else{
        NSLog(@"没有安装微信");
        return NO;
    }
}
- (void) changeScene:(NSInteger)scene
{
    _scene = scene;
}
- (void) sendLinkContent
{
    
}
@end
