//
//  SettingTableViewController.h
//  project4
//
//  Created by zack on 14-11-23.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISlider *silder;
- (IBAction)setSize:(id)sender;
- (IBAction)exit:(id)sender;

@end
