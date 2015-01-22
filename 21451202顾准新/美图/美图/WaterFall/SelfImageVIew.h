//
//  SelfImageVIew.h
//  美图
//
//  Created by 顾准新 on 14-12-23.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageInfo.h"
#import "UIImageView+WebCache.h"
//间距
#define SPACE 4
#define WIDTH [UIScreen mainScreen].applicationFrame.size.width/2

//@protocol ImageDelegate<NSObject>
//-(void)clickImage:(ImageInfo *)data;
//-(void)removeImg:(ImageInfo *)data;
//@end

typedef void (^clickImageBlock) (ImageInfo *);
typedef void (^removeImageBlock) (ImageInfo *);

@interface SelfImageVIew : UIView
//@property (nonatomic,weak)id<ImageDelegate> delegate;
@property (nonatomic,strong)ImageInfo *data;
@property (nonatomic,strong)clickImageBlock  didClickImage;
@property (nonatomic,strong)removeImageBlock  didRemoveImage;


-(id)initWithImageInfo:(ImageInfo*)imageInfo y:(float)y withA:(int)a;
@end
