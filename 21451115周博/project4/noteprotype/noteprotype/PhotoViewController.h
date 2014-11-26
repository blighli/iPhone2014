//
//  PhotoViewController.h
//  noteprotype
//
//  Created by zhou on 14/11/24.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "Photo.h"

@interface PhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic) UIImage *capturedImage;
@property Note* note;
@property Photo* photo;
@property BOOL isUpdate;
@end
