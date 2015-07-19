//
//  ViewController.h
//  AverNote
//
//  Created by Mz on 14-11-19.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Note;
@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *noteTable;
@property (nonatomic) NSMutableArray *notes;

@end

