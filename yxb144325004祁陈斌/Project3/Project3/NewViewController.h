//
//  NewViewController.h
//  Project3
//
//  Created by xsdlr on 14/11/6.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) id delegate;

- (IBAction)saveTask:(id)sender;
- (IBAction)close:(id)sender;

@end
