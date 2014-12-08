//
//  AddDrawViewController.h
//  Notes
//
//  Created by 陈聪荣 on 14/12/6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DrawView.h"
#import "NoteBiz.h"

@interface AddDrawViewController : UIViewController
@property (weak, nonatomic) IBOutlet DrawView *drawView;
@property (strong , nonatomic) NoteBiz *noteBiz;
- (IBAction)returnOnclick:(id)sender;
- (IBAction)saveOnclick:(id)sender;

@end
