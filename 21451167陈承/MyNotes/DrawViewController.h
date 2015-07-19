//
//  DrawViewController.h
//  MyNotes
//
//  Created by chencheng on 14/11/21.
//  Copyright (c) 2014年 jikexueyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *pictureTitle;

- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)tapBackground:(id)sender;
@end
