//
//  PhotoCell.h
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/19.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (nonatomic, strong) ALAsset *asset;

@end
