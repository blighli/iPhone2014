//
//  ZAddNoteViewController.h
//  Note
//
//  Created by Mac on 14-11-21.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZAddNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *topic;

@property (weak, nonatomic) IBOutlet UITextView *content;


@property (copy, nonatomic)  NSString *paramTopic;

@property (copy, nonatomic)   NSString *paramContent;

- (IBAction)saveButtonPressed:(UIButton *)sender;


@end
