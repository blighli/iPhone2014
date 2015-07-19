//
//  PhotoNoteViewController.h
//  AverNote
//
//  Created by Mz on 14-11-22.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@interface PhotoNoteViewController : UIImagePickerController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) ViewController *mainView;
@end
