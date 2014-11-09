//
//  ViewController.m
//  MyToDoList
//
//  Created by alwaysking on 14/11/8.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "DetailViewController.h"

@interface ViewController ()

@end
@implementation ViewController
@synthesize textFieldData;
@synthesize tableViewData;
@synthesize barBtnItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    tableData = [[NSMutableArray alloc]init];
    [self setExtraCellLineHidden:self.tableViewData];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [tableViewData reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![textFieldData.text isEqual: @""]) {
        
        [tableData insertObject:textFieldData.text atIndex:0];
        textFieldData.text = @"";
        [tableViewData reloadData];
    }
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)EditBtn:(id)sender{
    UIBarButtonItem * btnItem = (UIBarButtonItem *) sender;
    if ([[btnItem title] isEqual: @"编辑"]) {
        btnItem.title = @"完成";
        [textFieldData becomeFirstResponder];
    }
    else{
        btnItem.title = @"编辑";
        [self textFieldShouldReturn:textFieldData];
    }
}

//隐藏多余的线条
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
    barBtnItem.title = @"完成";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableDataRow = indexPath.row;
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"detailview"];
    [self presentViewController:next animated:YES completion:nil];
}


// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"Text field ended editing");
   barBtnItem.title = @"编辑";
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld",(long)indexPath.row)  ;
        [tableData removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationTop];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

@end
