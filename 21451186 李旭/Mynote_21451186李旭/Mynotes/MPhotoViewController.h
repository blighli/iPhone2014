//
//  MPhotoViewController.h
//  Mynotes
//
//  Created by lixu on 14/11/15.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDBAccess.h"

@interface MPhotoViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate>
@property  (strong,nonatomic) MDBAccess *dbAcess;

@end
