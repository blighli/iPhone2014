//
//  UpdateViewController.h
//  weiBo
//
//  Created by lixu on 15/1/10.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webServiceApi.h"

@interface UpdateViewController : UIViewController

- (IBAction)updateButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)cancelButton:(id)sender;

@property (strong,nonatomic) webServiceApi *webService;
@end
