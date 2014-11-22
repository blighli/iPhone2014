//
//  NewNote.h
//  mynote
//
//  Created by Devon on 14/11/21.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ViewController.h"

@protocol ImageDelegate

- (void)CallBack:(NSData *)data; //回调传值

@end

@interface NewNoteViewController : UIViewController<UIImagePickerControllerDelegate,ImageDelegate>

@property(nonatomic,retain)AppDelegate* myAppDelegate;
@property (nonatomic, copy) NSString *noteIndex;

- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)deletePhoto:(UIButton *)sender;
- (IBAction)drawPhott:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *noteName;
@property (weak, nonatomic) IBOutlet UITextView *noteContentText;
@property (weak, nonatomic) IBOutlet UIImageView *noteContentImage;

- (IBAction)saveNewNote:(UIBarButtonItem *)sender;

@end
