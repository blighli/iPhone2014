//
//  PhotoPickerViewController.h
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/19.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDelegate.h"

@interface PhotoPickerViewController : UIViewController<UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout>

//确定委托人，这是用assign防止引起循环引用
@property(nonatomic, assign) NSObject<UIPhotoDelegate> * delegate;

@end
