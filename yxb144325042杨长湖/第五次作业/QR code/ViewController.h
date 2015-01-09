//
//  ViewController.h
//  QR code
//
//  Created by 杨长湖 on 14/12/31.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ViewController : UIViewController< ZBarReaderDelegate,UIAlertViewDelegate >
@property (retain, nonatomic) IBOutlet UILabel *label;

@property (retain, nonatomic) IBOutlet UIImageView *imageview;
@property (retain, nonatomic) IBOutlet UITextField *text;

- (IBAction)button:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)Responder:(id)sender;


@end
