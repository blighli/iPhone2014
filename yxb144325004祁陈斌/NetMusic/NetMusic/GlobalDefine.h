//
//  GlobalDefine.h
//  NetMusic
//
//  Created by xsdlr on 14/12/1.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalDefine : NSObject
/**
 *  屏幕宽度
 *
 *  @return CGFloat
 */
+(CGFloat) ScreenWidth;
/**
 *  屏幕高度
 *
 *  @return CGFloat
 */
+(CGFloat) ScreenHeight;
/**
 *  导航栏高度
 *
 *  @return CGFloat
 */
+(CGFloat) NavigationHight;
/**
 *  状态栏高度
 *
 *  @return CGFloat
 */
+(CGFloat) StatusBarHeight;
/**
 *  顶部栏高度(包括状态栏和导航栏)
 *
 *  @return CGFloat
 */
+(CGFloat) HeaderHight;
/**
 *  底边栏高度
 *
 *  @return CGFloat
 */
+(CGFloat) FooterHight;
/**
 *  频道url
 *
 *  @return NSString
 */
+(NSString*) channelUrl;
/**
 *  歌曲url
 *
 *  @return NSString
 */
+(NSString*) songUrl;
/**
 *  主界面高度
 *
 *  @return CGFloat
 */
+(CGFloat) getBodyHeight;
/**
 *  设置主界面高度
 *
 *  @param height CGFloat高度
 */
+ (void) setBodyHeight:(CGFloat) height;
@end