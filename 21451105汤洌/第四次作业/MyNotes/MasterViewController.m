//
//  MasterViewController.m
//  MyNotes
//
//  Created by tanglie on 14/11/22.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "DBUtilis.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property DBUtilis *dbUtility;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    if (!self.dbUtility) {
        self.dbUtility = [[DBUtilis alloc] init];
    }
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
        self.objects = self.dbUtility.selectDataFromDB;
    }
}


- (void)viewDidAppear:(BOOL)animated{
    self.objects = self.dbUtility.selectDataFromDB;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showText"] || [[segue identifier] isEqualToString:@"showImage"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = nil;
    NSDictionary *data = [self.objects objectAtIndex:indexPath.row];
    NSString *type = data[@"type"];
    
    if ([type isEqual:@"text"]) {
        identifier = @"TextCell";
    }else{
        identifier = @"ImageCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    cellLabel.text = data[@"title"];
    if ([type isEqual:@"text"]) {
        UITextView *textView = (UITextView *)[cell viewWithTag:2];
        textView.text = data[@"text"];
    }else{
        UIImage *image = [UIImage imageWithData:data[@"image"]];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:3];
        imageView.image = image;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *data = [self.objects objectAtIndex:indexPath.row];
        [self.dbUtility deleteWithTitle:data[@"title"]];
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
