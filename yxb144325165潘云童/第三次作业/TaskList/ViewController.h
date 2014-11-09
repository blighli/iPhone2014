//
//  ViewController.h
//  TaskList
//
//  Created by Joker on 14/11/9.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>

+ (NSMutableArray*) getTasks;
+ (NSString*) docPath;
@end

