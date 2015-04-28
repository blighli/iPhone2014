//
//  GlobalDefine.m
//  NetMusic
//
//  Created by xsdlr on 14/12/1.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "GlobalDefine.h"

static CGFloat QCBBodyHeight;
@implementation GlobalDefine
+ (CGFloat)ScreenWidth {
    return UIScreen.mainScreen.bounds.size.width;
}
+ (CGFloat)ScreenHeight {
    return UIScreen.mainScreen.bounds.size.height;
}
+ (CGFloat)NavigationHight {
    return 44.0f;
}
+ (CGFloat)StatusBarHeight {
    return 20.0f;
}
+ (CGFloat)HeaderHight {
    return self.NavigationHight + self.StatusBarHeight;
}
+ (CGFloat)FooterHight {
    return 60.0f;
}
+ (NSString *)channelUrl {
    return @"http://www.douban.com/j/app/radio/channels";
}
+ (NSString *)songUrl {
//    return @"http://www.douban.com/j/app/radio/people";
    return @"http://douban.fm/j/mine/playlist";
}
+ (void) setBodyHeight:(CGFloat) height {
    QCBBodyHeight = height;
}
+ (CGFloat)getBodyHeight {
//    return GlobalDefine.ScreenHeight - GlobalDefine.HeaderHight;
    return QCBBodyHeight;
}
@end
