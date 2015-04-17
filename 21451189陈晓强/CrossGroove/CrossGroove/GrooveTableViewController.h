//
//  GrooveTableViewController.h
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/22.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewCell.h"
@interface GrooveTableViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MyTableViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *reviewArray;
@property (strong, nonatomic) NSString *topicID;
@property (strong, nonatomic) NSString *topicName;

@end
