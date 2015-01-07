//
//  XLComposeToolBar.h
//  XinLang
//
//  Created by 周舟 on 14-10-7.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLComposeToolBar;
typedef enum{
    XLComposeToolbarButtonTypeCamera,
    XLComposeToolbarButtonTypePicture,
    XLComposeToolbarButtonTypeMention,
    XLComposeToolbarButtonTypeTrend,
    XLComposeToolbarButtonTypeEmotion
}XLComposeToolbarButtonType;


@protocol XLComposeToolBarDelegate <NSObject>
@optional
- (void)composeToolBar:(XLComposeToolBar *)toolBar didClickButton:(XLComposeToolbarButtonType)buttonType;

@end

@interface XLComposeToolBar : UIView
@property (nonatomic, weak) id<XLComposeToolBarDelegate> delegate;
@end
