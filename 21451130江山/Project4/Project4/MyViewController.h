//
//  MyViewController.h
//  Project4
//
//  Created by 江山 on 1/8/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

- (IBAction)takephoto:(id)sender;
- (IBAction)save:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *textfield;
@property (retain, nonatomic) IBOutlet UITextView *textview;


@end
