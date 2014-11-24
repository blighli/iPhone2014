//
//  detailCameraViewController.h
//  Evernote
//
//  Created by JANESTAR on 14-11-23.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Camera.h"
@interface detailCameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UITextView * contenttextview;
    UIImageView* contentimageview;
    NSString* lastChosenMediaType;



}
@property(nonatomic,retain)UITextView* contenttextview;
@property(nonatomic,retain)UIImageView* contentimageview;
@property(nonatomic,retain)NSString* lastChosenMediaType;
@property(nonatomic)BOOL mark;
@property(nonatomic)NSUInteger row;
@property(nonatomic)BOOL flag;
@property(nonatomic,strong)Camera* camera;

@end
