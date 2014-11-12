//
//  ViewController.h
//  task
//
//  Created by 黄盼青 on 14/11/5.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *taskTable;
@property (strong, nonatomic) NSMutableArray *tasks;


-(void)readDataFromFile;
-(void)writeDataToFile;


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

