//
//  rootViewController.m
//  MyNotes
//
//  Created by Frank Yuan on 14-12-25.
//  Copyright (c) 2014年 Frank Yuan. All rights reserved.
//



#import "rootViewController.h"
#import "addNoteViewController.h"
#import "noteDetailViewController.h"

@interface rootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property NSMutableArray *filteredNoteArray;
@end

@implementation rootViewController
@synthesize noteArray,dateArray,filteredNoteArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.noteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    self.dateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addbtn = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStyleBordered target:self action:@selector(addnote)];
    self.navigationItem.rightBarButtonItem = addbtn;
    self.navigationItem.title = @"我的记事本";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [noteArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *note  = nil;
    if(tableView == self.tableView){
        note = [noteArray objectAtIndex:indexPath.row];
    };
    NSString *date = [dateArray objectAtIndex:indexPath.row];
    NSUInteger charnum = [note length];
    if (charnum < 22) {
        cell.textLabel.text = note;
    }
    else{
        cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"..."];
    }
    cell.detailTextLabel.text = date;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    noteDetailViewController *modifyCtrl = [[noteDetailViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:modifyCtrl animated:NO];
    NSInteger row = [indexPath row];
    modifyCtrl.index = row;
}

- (void)addnote{
    addNoteViewController *detailViewCtrl = [[addNoteViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
    
}

@end
