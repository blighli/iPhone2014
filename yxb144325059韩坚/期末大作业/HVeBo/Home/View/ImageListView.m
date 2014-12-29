//
//  ImageListView.m
//  HVeBo
//
//  Created by HJ on 14/12/8.
//  Copyright (c) 2014年 hj. All rights reserved.
//
#define kCount 9

#define kOneW 120
#define kOneH 120

#define kMultiW 80
#define kMultiH 80

#define kMargin 5
#import "ImageListView.h"
#import "ImageItemView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface ImageItemView()


@end

@implementation ImageListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 先把有可能显示的控件都加进去
        for (int i = 0; i<kCount; i++) {
            ImageItemView *imageView = [[ImageItemView alloc] init];
            
            imageView.tag = i;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAction:)]];
            imageView.userInteractionEnabled = YES;
            [self addSubview:imageView];
        }
    }
    return self;
}
#pragma mark - 图片点击放大事件
- (void)imageAction:(UITapGestureRecognizer *)recognizer
{
    NSInteger count = _imageUrls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        mjphoto.url = [NSURL URLWithString:[_imageUrls[i][@"thumbnail_pic"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"]]; // 图片路径bmiddle(中等)
        
        [photos addObject:mjphoto];
    }
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}
- (void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    NSInteger count = imageUrls.count;
    for (int i = 0; i<kCount; i++) {
        // 1.取出对应位置的子控件
        ImageItemView *child = self.subviews[i];
        
        // 2.不要显示图片
        if (i >= count) {
            child.hidden = YES;
            continue;
        }
        
        // 需要显示图片
        child.hidden = NO;
        
        // 3.设置图片
        child.url = imageUrls[i][@"thumbnail_pic"];
        
        // 4.设置frame
        if (count == 1) { // 1张
            child.frame = CGRectMake(0, 0, kOneW, kOneH);
            child.contentMode = UIViewContentModeScaleAspectFit;
            continue;
        }
        
        // 超出边界的减掉
        child.clipsToBounds = YES;
        child.contentMode = UIViewContentModeScaleAspectFill;
        
        int temp = (count == 4) ? 2 : 3;
        CGFloat row = i/temp; // 行号
        CGFloat column = i%temp; // 列号
        CGFloat x = (kMultiW + kMargin) * column;
        CGFloat y = (kMultiH + kMargin) * row;
        child.frame = CGRectMake(x, y, kMultiW, kMultiH);
    }
}

+ (CGSize)imageListSizeWithCount:(NSInteger)count
{
    // 1.只有1张图片
    if (count == 1) {
        return CGSizeMake(kOneW, kOneH);
    }
    // 2.至少2张图片
    CGFloat countRow = (count == 4) ? 2 : 3;
    // 总行数
    int rows = (count + countRow - 1) / countRow;
    // 总列数
    int columns = (count >= 3) ? 3 : 2;
    
    CGFloat width = columns * kMultiW + (columns - 1) * kMargin;
    CGFloat height = rows * kMultiH + (rows - 1) * kMargin;
    return CGSizeMake(width, height);
}
@end
