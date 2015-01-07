//
//  XLPhotoView.m
//  XinLang
//
//  Created by 周舟 on 14-10-4.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLPhotoView.h"
#import "UIImageView+WebCache.h"
#import "XLPhoto.h"

@interface XLPhotoView()
@property (nonatomic, weak) UIImageView *gifView;


@end

@implementation XLPhotoView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIImageView *gifView = [[UIImageView alloc] init];
        gifView.image = [UIImage imageNamed:@"timeline_image_gif"];
        gifView.bounds = CGRectMake(0, 0,  gifView.image.size.width,  gifView.image.size.height);
        gifView.hidden  = YES;
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    
    return self;
}
/**
 *  设置数控i
 *
 *  @param photo 图片
 */
-(void)setPhoto:(XLPhoto *)photo
{
    _photo =photo;
    NSString *url = photo.thumbnail_pic;
   
    if ([url hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }
    
    //NSLog(@"--photo.thumbnail_pic:%@",photo.thumbnail_pic);
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
    
}
@end
