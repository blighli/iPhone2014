//
//  TopicTableViewController.h
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/23.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrooveShow.h"
 
@interface TopicTableViewController : UITableViewController<GrooveFieldDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *MyNaviga;

@end
