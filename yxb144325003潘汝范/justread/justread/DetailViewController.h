//
//  ViewController.h
//  justread
//
//  Created by Van on 14/12/3.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "Stories.h"
#import "AppDelegate.h"

@interface DetailViewController : UIViewController

@property (nonatomic) Stories *story;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) Boolean isFaved;
@end

