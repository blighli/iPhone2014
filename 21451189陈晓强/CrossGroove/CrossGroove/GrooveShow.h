//
//  GrooveShow.h
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/28.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GrooveFieldDelegate;
@interface GrooveShow : UIView

- (id)initWithTitle:(NSString *)title
  cancleButtonTitle:(NSString *)cancleTitle
      okButtonTitle:(NSString *)okTitle;

- (void)show;

@property (weak, nonatomic) id<GrooveFieldDelegate> delegate;

@end


@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *) color;

@end


@protocol GrooveFieldDelegate <NSObject>

@optional
- (void)grooveShow:(GrooveShow *)grooveShow andChangeTextField:(UITextField *)textField;

@end