//
//  ActivityIndicator.m
//  RSSReader
//
//  Created by Mz on 14-12-12.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "ActivityIndicator.h"
#import "MONActivityIndicatorView.h"

@interface ActivityIndicator () <MONActivityIndicatorViewDelegate>
@property (nonatomic, strong) MONActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIView *shadowView;
@end

static ActivityIndicator *sharedInstance;

@implementation ActivityIndicator

+ (ActivityIndicator *)sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[ActivityIndicator alloc] init];
    }
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        // Shadow View
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _shadowView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _shadowView.backgroundColor = [UIColor blackColor];
        _shadowView.alpha = 0.5f;
    }
    return self;
}

- (void)start:(UIViewController*) vc {
    if (!_indicatorView) {
        _indicatorView = [[MONActivityIndicatorView alloc] init];
        _indicatorView.delegate = self;
        _indicatorView.numberOfCircles = 3;
        _indicatorView.radius = 20;
        _indicatorView.internalSpacing = 3;
        _indicatorView.center = vc.view.center;
    }
    [vc.view addSubview:_shadowView];
    [vc.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
}

- (void)stop {
    if (_indicatorView) {
        [_indicatorView stopAnimating];
        [_indicatorView removeFromSuperview];
        [_shadowView removeFromSuperview];
    }
}

#pragma mark -
#pragma mark - MONActivityIndicatorViewDelegate Methods

- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
