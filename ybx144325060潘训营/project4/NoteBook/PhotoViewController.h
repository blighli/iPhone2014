//
//  PhotoViewController.h
//  NoteBook
//
//  Created by Mz on 14-11-23.
//  Copyright (c) 2014年 pxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@interface PhotoViewController : UIImagePickerController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) ViewController *mainView;
@end
