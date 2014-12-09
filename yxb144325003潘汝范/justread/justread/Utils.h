//
//  Utils.h
//  justread
//
//  Created by Van on 14/12/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "Stories.h"
#import "WXApi.h"

@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) changeScene:(NSInteger)scene;
- (void) sendLinkContent;

@end
@interface Utils : NSObject <WXApiDelegate,sendMsgToWeChatViewDelegate>{
 
    NSString* callback;
    enum WXScene _scene;
}
- (Boolean) shareToWechatwith :(NSString *)title
                          with:(NSString *)description
                          with:(NSString *)shareUrl
                          with:(BOOL)isSendToTimeline;
- (NSMutableArray *) getResult:(NSManagedObjectContext *)managedObjectContext;
- (UIColor *) stringToColor:(NSString *)str;
- (BOOL) serachWith:(Stories *) stories and:(NSManagedObjectContext *) managedObjectContext;
@end
