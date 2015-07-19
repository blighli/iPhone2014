//
//  HandDrawnNotesViewController.m
//  Mynotes
//
//  Created by xiaoo_gan on 11/28/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "HandDrawnNotesViewController.h"
#import "HandDrawnNotesDetailViewController.h"

#import "HandDrawnDataSource.h"
#import "HandDrawnData.h"

@interface HandDrawnNotesViewController ()

@end

@implementation HandDrawnNotesViewController

- (void) awakeFromNib
{
    [super awakeFromNib];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    if ([[HandDrawnDataSource sharedInstance] noteCount] % 2 == 1) {
        self.tableView.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1];
    } else {
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
}
- (void) viewDidUnload
{
    [super viewDidUnload];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[HandDrawnDataSource sharedInstance] noteCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HandDrawnCell"];
    
    HandDrawnData *note = [[HandDrawnDataSource sharedInstance] getNoteAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[note title]];
    cell.detailTextLabel.text = [ note dateString];
    cell.imageView.image = [note image];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[HandDrawnDataSource sharedInstance] removeNoteAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer_view = [[UIView alloc] init];
    return footer_view;
}
- (float) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

//segue处理
#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //查看选中记事
    if ([[segue identifier] isEqualToString:@"showHandDrawnNoteDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HandDrawnData *note = [[HandDrawnDataSource sharedInstance] getNoteAtIndex:indexPath.row];
        [[segue destinationViewController] setHandDrawnNote:note];
        NSLog(@"%@",segue.destinationViewController);
        [[segue destinationViewController] setRowIndex:indexPath.row];
    }
}
@end
