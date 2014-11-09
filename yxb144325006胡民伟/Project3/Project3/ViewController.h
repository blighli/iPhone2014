//
//  ViewController.h
//  Project3
//
//  Created by Cocoa on 14/11/9.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
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

