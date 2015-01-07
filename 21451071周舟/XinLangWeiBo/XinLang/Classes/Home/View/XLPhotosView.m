//
//  XLPhotosView.m
//  XinLang
//
//  Created by 周舟 on 14-10-4.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLPhotosView.h"
#import "XLPhotoView.h"
#import "XLPhoto.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhotoView.h"

@implementation XLPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for(int i = 0;i < 9; i ++)
        {
            XLPhotoView *photoView = [[XLPhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
            
        }
    }
    return self;
}


- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
    int count = self.photos.count;
    
    //1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i ++) {
        //
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.subviews[i];
        XLPhoto *xlPhoto = self.photos[i];
        
        NSString *photoUrl = [xlPhoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        mjphoto.url = [NSURL URLWithString:photoUrl];
        
        [myphotos addObject:mjphoto];
        
    }
    //2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag;
    browser.photos = myphotos;
    [browser show];
}

+(CGSize)photoViewSizeWithPhotoCount:(int)count{
    if (count == 1) {
        return CGSizeMake(XLSinglePhotoWH + XLPhotoMargin, XLSinglePhotoWH + XLPhotoMargin);
    }else{
        int rows = (count + 2) / 3;
        CGFloat photosW = (XLPhotoW + XLPhotoMargin) * 3;
        CGFloat photosH = (XLPhotoH + XLPhotoMargin) * rows;
        return CGSizeMake(photosW, photosH);
        
    }
        
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for (int i = 0; i < self.subviews.count; i ++) {
        //
        XLPhotoView *photoView = self.subviews[i];
        if (i < photos.count)
        {
            photoView.hidden = NO;
            //
            photoView.photo = photos[i];
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = YES;
                photoView.frame = CGRectMake(0, 0, XLSinglePhotoWH, XLSinglePhotoWH);
            }else{
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
                
                int maxColumns = (photos.count == 4) ? 2:3;
                int col = i % maxColumns;
                int row = i / maxColumns;
                CGFloat photoX = col * (XLPhotoW + XLPhotoMargin);
                CGFloat photoY = row * (XLPhotoH + XLPhotoMargin);
                photoView.frame = CGRectMake(photoX, photoY, XLPhotoW, XLPhotoH);
            }
            
        }else{
            photoView.hidden = YES;
        }
        
    }
    
    
}

@end
