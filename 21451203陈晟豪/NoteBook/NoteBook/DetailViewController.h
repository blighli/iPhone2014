//
//  DetailViewController.h
//  NoteBook
//
//  Created by 陈晟豪 on 14/11/25.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *detailSaveButton;


- (IBAction)pressedButtonItem:(UIBarButtonItem *)sender;
@end
