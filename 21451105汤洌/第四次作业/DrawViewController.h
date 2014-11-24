//
//  DrawViewController.h
//  MyNotes
//
//  Created by tanglie on 14/11/22.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *pictureTitle;

- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)tapBackground:(id)sender;
@end
