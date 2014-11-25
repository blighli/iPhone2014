//
//  ViewController.h
//  NoteBook
//
//  Created by Mz on 14-11-23.
//  Copyright (c) 2014年 pxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *noteData;

@end

