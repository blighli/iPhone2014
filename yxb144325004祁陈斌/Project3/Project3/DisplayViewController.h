//
//  DisplayViewController.h
//  Project3
//
//  Created by xsdlr on 14/11/6.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) NSNumber* taskIndex;
@property (weak, nonatomic) id delegate;
- (IBAction)close:(id)sender;
- (IBAction)complete:(id)sender;

@end
