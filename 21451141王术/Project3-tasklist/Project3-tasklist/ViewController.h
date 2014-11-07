//
//  ViewController.h
//  Project3-tasklist
//
//  Created by  ws on 14/11/6.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
NSMutableArray *_tasks;
@interface ViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>



NSString *docPath(void);
@end

