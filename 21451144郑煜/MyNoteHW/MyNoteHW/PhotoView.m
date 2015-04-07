//
//  PhotoView.m
//  TODOListHW
//
//  Created by StarJade on 14-11-24.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "PhotoView.h"

#import <QuartzCore/QuartzCore.h>

@interface PhotoView ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 1.0f, 1.0f)];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.indicatorView.hidesWhenStopped = YES;
        self.indicatorView.center = self.center;
        [self addSubview:self.indicatorView];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor colorWithWhite:1.0f alpha:0.9f] setStroke];
    UIRectFrame(rect);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.indicatorView startAnimating];
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.imageView.image = image;
        [self.indicatorView stopAnimating];
    });
}

@end

