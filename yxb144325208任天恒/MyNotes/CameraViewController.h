//
//  CameraViewController.h
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface CameraViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    sqlite3 *cameraDB;
    NSString *databasePath2;
}


@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *photo;

- (IBAction)takePhoto:(id)sender;

@end
