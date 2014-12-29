//
//  ImageListView.h
//  HVeBo
//
//  Created by HJ on 14/12/8.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListView : UIView
// 所有图片的url
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, readonly) CGSize imageListViewSize;

+ (CGSize)imageListSizeWithCount:(NSInteger)count;
@end
