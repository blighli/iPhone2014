//
//  GrooveShow.m
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/28.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "GrooveShow.h"
#import <QuartzCore/QuartzCore.h>


#define kGrooveWidth 250.0f
#define kGrooveHeight 140.0f

@interface GrooveShow()

@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *okButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *grooveTextField;
@property (nonatomic, strong) UIView *backImageView;


@end

@implementation GrooveShow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title cancleButtonTitle:(NSString *)cancleTitle okButtonTitle:(NSString *)okTitle
{

    if (self = [super init]) {
#define kTitleOffset 15.0f
#define kTitleHeight 30.0f

    self.layer.cornerRadius = 6.0;
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleOffset, kGrooveWidth, kTitleHeight)];
    self.titleLabel.font =[UIFont boldSystemFontOfSize:20.0f];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame),
                                                                    kGrooveWidth, 1.0f)];
        lineView1.backgroundColor = [UIColor colorWithRed:221.0/255 green:221.0/255 blue:221.0/255 alpha:0.8];
        [self addSubview:lineView1];
#define kTextFieldHeight 40.0f
    self.grooveTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), kGrooveWidth, kTextFieldHeight)];
    self.grooveTextField.font = [UIFont boldSystemFontOfSize:20.f];
    self.grooveTextField.borderStyle = UITextBorderStyleNone;
    self.grooveTextField.textColor = [UIColor blackColor];
    [self addSubview:self.grooveTextField];
    //设置下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.grooveTextField.frame),
                                                                kGrooveWidth, 1.0f)];
    lineView.backgroundColor = [UIColor colorWithRed:221.0/255 green:221.0/255 blue:221.0/255 alpha:0.8];
    [self addSubview:lineView];
    
#define kButtonWidth 107.0f
#define kButtonHeight 40.0f
#define kButtonBottomOffset 10.0f
    CGRect cancelBtnFrame;
    CGRect okBtnFrame;
    
    cancelBtnFrame = CGRectMake((kGrooveWidth - 2.0*kButtonWidth - kButtonBottomOffset)*0.5, CGRectGetMaxY(lineView.frame) +5, kButtonWidth, kButtonHeight);
    okBtnFrame = CGRectMake(CGRectGetMaxX(cancelBtnFrame) + kButtonBottomOffset, CGRectGetMaxY(lineView.frame) +5 , kButtonWidth, kButtonHeight);
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = cancelBtnFrame;
    self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.okButton.frame = okBtnFrame;
    //cancel
    [self.cancelButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:236.0/255 green:67.0/255 blue:71.0/255 alpha:1.0]] forState:UIControlStateNormal];
    [self.cancelButton setTitle:cancleTitle forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //ok
    [self.okButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:87.0/255 green:128.0/255 blue:244.0/255 alpha:1.0]] forState:UIControlStateNormal];
    [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.okButton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.okButton setTitle:okTitle forState:UIControlStateNormal];
    
    self.cancelButton.titleLabel.font = self.okButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.cancelButton.layer.masksToBounds = self.okButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = self.okButton.layer.cornerRadius =  3.0f;
    
    [self addSubview:self.cancelButton];
    [self addSubview:self.okButton];
    UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xButton setImage:[UIImage imageNamed:@"btn_close_normal.png"] forState:UIControlStateNormal];
    [xButton setImage:[UIImage imageNamed:@"btn_close_selected.png"] forState:UIControlStateHighlighted];
    xButton.frame = CGRectMake(kGrooveWidth- 32, 0, 32, 32);
    [self addSubview:xButton];
    [xButton addTarget:self action:@selector(dismissGroove) forControlEvents:UIControlEventTouchUpInside];
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}
+ (CGFloat)grooveWidth
{
    return kGrooveWidth;
}

+ (CGFloat)grooveHeight
{
    return kGrooveHeight;
}





- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kGrooveWidth) * 0.5, - kGrooveHeight - 30,
                            kGrooveWidth, kGrooveHeight);
    [topVC.view addSubview:self];
    
}

- (void)dismissGroove
{
    [self removeFromSuperview];
}
- (void)cancelButtonClick:(id)sender
{
    [self dismissGroove];
}

- (void)okButtonClick:(id)sender
{
    [self.delegate grooveShow:self andChangeTextField:self.grooveTextField];
    
    [self dismissGroove];

}

- (void)removeFromSuperview
{
    
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kGrooveWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kGrooveWidth, kGrooveHeight);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);


    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kGrooveWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kGrooveHeight) * 0.5 - 50, kGrooveWidth, kGrooveHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
        NSLog(@"what？");
    }];
    
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


@end


@implementation UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

