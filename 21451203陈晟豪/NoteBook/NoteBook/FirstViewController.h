//
//  FirstViewController.h
//  NoteBook
//
//  Created by 陈晟豪 on 14/11/21.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UINavigationBar *firstNavigationBar;
@property (weak, nonatomic) IBOutlet UITextField *diaryTitle;

- (IBAction)clickCancelButton:(id)sender;
//- (IBAction)clickCameraButton:(id)sender;
- (IBAction)clickSaveButton:(id)sender;
@end

