//
//  PhotoCell.m
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/19.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@end

@implementation PhotoCell

- (void)setAsset:(ALAsset *)asset
{
    _asset = asset;
    self.photoImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
}
@end
