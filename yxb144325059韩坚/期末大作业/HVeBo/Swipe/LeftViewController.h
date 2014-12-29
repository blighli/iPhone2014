//
//  LeftViewController.h
//  HVeBo
//
//  Created by HJ on 14/12/14.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@protocol leftSelectedFeatureDelegate <NSObject>
@optional
- (void)didSelectedFrature:(NSString *)frature;
- (void)didSelectedMoreWitch:(BOOL)more;
- (void)didSelectedHidenSwitch:(BOOL)hidden;
- (void)login;
- (void)startAction;
@end



@interface LeftViewController : UITableViewController

- (IBAction)loginBtn:(UIButton *)sender;
- (IBAction)logoutBtn:(UIButton *)sender;
- (IBAction)moreSwitch:(UISwitch *)sender;
- (IBAction)hiddenSwitch:(UISwitch *)sender;
- (IBAction)clearBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@property (nonatomic, weak) id<leftSelectedFeatureDelegate> degetalte;

@end
