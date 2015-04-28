//
//  UIButtonMake.m
//  NetMusic
//
//  Created by xsdlr on 14/12/2.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "UIButtonMake.h"

@interface UIButtonMake()

@end

@implementation UIButtonMake

+ (UIButton *)createWithTarget:(id)target
                        action:(SEL)action
                        events:(UIControlEvents) events {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:target action:action forControlEvents:events];
    return button;
}

+ (UIButton *)createWithTitle:(NSString *)title
                        width:(CGFloat)width
                       height:(CGFloat) height
                       target:(id)target
                       action:(SEL)action
                       events:(UIControlEvents) events{
    UIButton *button = [self createWithTarget:target action:action events:events];
    button.frame = CGRectMake(0, 0, width, height);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1.000] forState:UIControlStateHighlighted];
//    button.titleLabel.font =  [UIFont systemFontOfSize: 14.0];
    [button addTarget:target action:action forControlEvents:events];
    return button;
}

+ (UIButton *)createWithImage:(UIImage *)image
                selectedimage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action
                       events:(UIControlEvents)events {
    UIButton *button = [self createWithTarget:target action:action events:events];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateHighlighted];
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    return button;
}

+ (UIButton *)createWithImage:(UIImage *)image
                selectedimage:(UIImage *)selectedImage
                        frame:(CGRect) frame
                       target:(id)target
                       action:(SEL)action
                       events:(UIControlEvents)events {
    UIButton *button = [self createWithTarget:target action:action events:events];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    return button;
}
@end