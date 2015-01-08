//
//  SecondTableViewController.m
//  Homework4
//
//  Created by 李丛笑 on 14/11/24.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "SecondTableViewController.h"
#import "FirstViewController.h"
#import "DB.h"
#import "Data.h"
#import <sqlite3.h>
#define kFilename @"data.sqlite3"



@interface SecondTableViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>



@end

@implementation SecondTableViewController
{

NSMutableArray *datas;
NSString *indexrow;
    int delete;
    DB *db;
}



-(NSString*)dataFilePath
{
    NSArray *DirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* DocuMentDir = [DirPath objectAtIndex:0];
    
    return [DocuMentDir stringByAppendingPathComponent:kFilename];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    db = [[DB alloc]init];
    datas = [db QueryDB];
    delete = 0;
    [self.tableView reloadData];
    NSLog(@"%d",datas.count);
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
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
    return datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    Data *data = [[Data alloc]init];
    data = [datas objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = data.title;
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
    
      indexrow = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if(delete ==1)
    {
        [db deleteData:indexrow];
        [self.tableView reloadData];
    }
    else
    [self performSegueWithIdentifier:@"tothird" sender:self];
    //indexs = indexPath;
  
   
   // FirstViewController *first = [[FirstViewController alloc]init];
    // [self.navigationController pushViewController:first animated:YES];
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
    NSString *count = [NSString stringWithFormat:@"%d",datas.count];
    if ([segue.identifier isEqualToString:@"tothird"]==YES) {
        ThirdViewController *thirdview =(ThirdViewController *)view;
        [thirdview setValue:indexnumber forKey:@"param"];
    }
    if ([segue.identifier isEqualToString:@"secondtofirst"]==YES) {
        ThirdViewController *thirdview =(ThirdViewController *)view;
        [thirdview setValue:count forKey:@"thiscount"];
    }

//    if ([view respondsToSelector:@selector(setParam:)]) {
//        [view setValue:in forKey:@"param"];
//    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)TEST:(id)sender {
    delete = 1-delete;
}
@end
