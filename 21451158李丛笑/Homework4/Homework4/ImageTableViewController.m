//
//  ImageTableViewController.m
//  Homework4
//
//  Created by 李丛笑 on 15/1/9.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import "ImageTableViewController.h"
#import "CameraViewController.h"
#import "DBHelper.h"
#import "Data.h"
@interface ImageTableViewController ()

@end

@implementation ImageTableViewController
@synthesize imagetableView;
NSMutableArray *datas;
NSString *indexrow;
DBHelper *db;

-(void) viewDidAppear:(BOOL)animated
{
    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    db = [[DBHelper alloc]init];
    datas = [[NSMutableArray alloc]init];
    [db CreateDB];
    datas = [db QueryDB];
    int count = [datas count];
    for (int i = 0; i < [datas count]; i++) {
        Data *data = [datas objectAtIndex:i];
        if ([data.contentid hasSuffix:@"0"]) {
            [datas removeObjectAtIndex:i];
            i--;
        }
    }
    [imagetableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [datas count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    Data *data = [[Data alloc]init];
    data = [datas objectAtIndex:indexPath.row];
    cell.textLabel.text = data.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    indexrow = [NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
    NSLog(indexrow);
    
    // FirstViewController *first = [[FirstViewController alloc]init];
    if([indexrow intValue]<=[datas count])
        [self performSegueWithIdentifier:@"oldCamera" sender:self];
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController* view = segue.destinationViewController;
    NSString *indexnumber = indexrow;
    //   NSString *count = [NSString stringWithFormat:@"%d",[datas count]];
    
    if ([segue.identifier isEqualToString:@"oldCamera"]==YES ) {
        CameraViewController *cameraview =(CameraViewController *)view;
        [cameraview setValue:indexrow forKey:@"imagecount"];
    }
    if ([segue.identifier isEqualToString:@"newCamera"]==YES ) {
        CameraViewController *cameraview = (CameraViewController *)view;
        [cameraview setValue:[NSString stringWithFormat:@"%d",(int)[datas count]+1] forKey:@"imagecount"];
    }

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}




@end
