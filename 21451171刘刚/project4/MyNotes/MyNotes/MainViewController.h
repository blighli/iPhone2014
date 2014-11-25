//
//  MainViewController.h
//  MyNotes
//
//  Created by liug on 14-11-15.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import <UIKit/UIKit.h>
NSMutableArray *tasklist,*tasklist2;
@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tasktable;
@end
