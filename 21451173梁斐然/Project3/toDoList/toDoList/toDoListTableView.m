//
//  toDoListTableView.m
//  toDoList
//
//  Created by LFR on 14/11/10.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import "toDoListTableView.h"
#import "Model.h"
#import "todoListTableViewCell.h"

@interface toDoListTableView ()

@property (nonatomic, strong) Model *model;

@end

@implementation toDoListTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.model = [Model sharedInstance];
}


- (IBAction)addTodo:(UIBarButtonItem *)sender {
    [self.model.listArray addObject:@""];
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_model.listArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    todoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todo" forIndexPath:indexPath];
    cell.textView.text = _model.listArray[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.model.listArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

@end
