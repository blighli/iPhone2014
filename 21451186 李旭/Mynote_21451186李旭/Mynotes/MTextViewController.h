//
//  MTextViewController.h
//  Mynotes
//
//  Created by lixu on 14/11/15.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDBAccess.h"
#import "Datas.h"

@interface MTextViewController : UIViewController<UIAlertViewDelegate>
- (IBAction)saveText:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end
