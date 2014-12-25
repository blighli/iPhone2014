//
//  BaseViewController.h
//  HVeBo
//
//  Created by HJ on 14/12/19.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaseViewDelegate <NSObject>
@optional
- (void)disappear;
@end

@interface BaseViewController : UIViewController
@property (nonatomic, weak) id<BaseViewDelegate> delegate;
//状态栏上面的提示
- (void)showStatuxsTip:(BOOL)show title:(NSString *)title;
@end
