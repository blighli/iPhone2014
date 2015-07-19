//
//  PublicViewController.h
//  weiBo
//
//  Created by lixu on 15/1/9.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webServiceApi.h"


@interface PublicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) webServiceApi* webRequest;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *plkArray;
- (IBAction)share:(id)sender;
- (IBAction)comment:(id)sender;
- (IBAction)favour:(id)sender;

@end