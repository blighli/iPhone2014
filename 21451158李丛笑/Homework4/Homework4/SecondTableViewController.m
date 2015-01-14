//
//  SecondTableViewController.m
//  Homework4
//
//  Created by 李丛笑 on 14/11/24.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "SecondTableViewController.h"
#import "FirstViewController.h"
#import "DBHelper.h"
#import "Data.h"
#import <sqlite3.h>
#define kFilename @"data.sqlite3"



@interface SecondTableViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>



@end

@implementation SecondTableViewController
@synthesize tableView;

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
    for (int i = 0; i<[datas count]; i++) {
        Data *data = [datas objectAtIndex:i];
        if ([data.contentid hasSuffix:@"1"]) {
            [datas removeObjectAtIndex:i];
            i--;
        }
    }
    [tableView reloadData];
   
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
   // indexs = indexPath;
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
      indexrow = [NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
    NSLog(indexrow);
//    if(delete ==1)
//    {
//        [db deleteData:indexrow];
//        [self.tableView reloadData];
//    }
//    else
     // [self performSegueWithIdentifier:@"tothird" sender:self];
    //indexs = indexPath;
  
   
   // FirstViewController *first = [[FirstViewController alloc]init];
    if([indexrow intValue]<=[datas count])
    [self performSegueWithIdentifier:@"oldone" sender:self];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
   
    if ([segue.identifier isEqualToString:@"oldone"]==YES ) {
        FirstViewController *firstview =(FirstViewController *)view;
        [firstview setValue:indexrow forKey:@"textcount"];
    }
    if ([segue.identifier isEqualToString:@"newone"]==YES ) {
        FirstViewController *firstview =(FirstViewController *)view;
        [firstview setValue:[NSString stringWithFormat:@"%d",[datas count]+1] forKey:@"textcount"];
    }

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)TEST:(id)sender {
    [db CreateDB];
    NSArray *RE = [db QueryDB];
    [db deleteData:@"1 0"];
}
@end
