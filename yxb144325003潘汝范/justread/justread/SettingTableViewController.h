//
//  SettingTableViewController.h
//  justread
//
//  Created by Van on 14/12/8.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController
- (IBAction)nightClick:(id)sender;

- (IBAction)imageClick:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *nightSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *downloadImageSwitch;
@property (weak, nonatomic) IBOutlet UILabel *nightLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;
@property (weak, nonatomic) IBOutlet UILabel *useLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellOne;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellTwo;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellThree;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellFour;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
- (IBAction)infoClick:(id)sender;
@end
