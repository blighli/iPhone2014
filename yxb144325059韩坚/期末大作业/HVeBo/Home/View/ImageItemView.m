//
//  ImageItemView.m
//  HVeBo
//
//  Created by HJ on 14/12/10.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "ImageItemView.h"
#import "HttpTool.h"
#import "UIViewController+MMDrawerController.h"

@interface ImageItemView()
{
    UIImageView *_gifView;
    UIImageView *_imageView;
}

@end
@implementation ImageItemView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        //从父控件继承按钮响应事件
//        self.userInteractionEnabled = YES;
        _gifView = [[UIImageView alloc]initWithImage:[ UIImage imageNamed:@"timeline_image_gif.png"]];
        [self addSubview:_gifView];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageAction)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)setUrl:(NSString *)url
{
    _url =url;
    [HttpTool dowloadImage:url iamgeview:self placeHolder:[UIImage imageNamed:@"message_placeholder_picture.png"]];
    _gifView.hidden = ![url.lowercaseString hasSuffix:@"gif"];
}
- (void) setFrame:(CGRect)frame
{
    CGRect gifFrame = _gifView.frame;
    gifFrame.origin.x = frame.size.width - gifFrame.size.width;
    gifFrame.origin.y = frame.size.height - gifFrame.size.height;
    _gifView.frame =  gifFrame;
    [super setFrame:frame];
}
#pragma mark - 图片点击放大事件
//- (void)imageAction
//{
//    if (_imageView == nil) {
//        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5,20,20)];
//        _imageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
//        _imageView.userInteractionEnabled = YES;
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageViewAction:)];
//        [_imageView addGestureRecognizer:tapGesture];
//    }
//    //NSLog(@"%@",_url);
//    NSString *largeUrl = [_url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//    [HttpTool dowloadImageBig:largeUrl iamgeview:_imageView placeHolder:[UIImage imageNamed:@"message_placeholder_picture.png"]];
//    [self.window addSubview:_imageView];
//    [UIView animateWithDuration:0.4 animations:^{
//        _imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    } completion:nil];
//    
//}
//- (void)scaleImageViewAction:(UIGestureRecognizer *)tap
//{
//    [UIView animateWithDuration:0.4 animations:^{
//        _imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5,20,20);
//    } completion:^(BOOL finished) {
//        [_imageView removeFromSuperview];
//    }];
//}
@end
