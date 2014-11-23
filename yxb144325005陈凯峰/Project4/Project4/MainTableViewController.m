//
//  MainTableViewController.m
//  Project4
//
//  Created by jingcheng407 on 14-11-23.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import "MainTableViewController.h"
#import "MyNote.h"
#import "AppDelegate.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    
    AppDelegate* myAppDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate] ;//获取委托
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MyNote"inManagedObjectContext:[myAppDelegate managedObjectContext]];
    //设置请求实体
    [request setEntity:entity];
    
    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[[myAppDelegate managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else{
        _TableViewListArray=mutableFetchResult;
    }
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _TableViewListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    
    // Configure the cell...
    MyNote* myNote=(MyNote*)[_TableViewListArray objectAtIndex:[indexPath row]];
    cell.textLabel.text=myNote.time;
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_MainTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([((MyNote*)[_TableViewListArray objectAtIndex:indexPath.row]).type isEqualToString:@"text"]){
        [self performSegueWithIdentifier:@"myShowTextView" sender:[NSNumber numberWithInteger:indexPath.row]];
    }else if ([((MyNote*)[_TableViewListArray objectAtIndex:indexPath.row]).type isEqualToString:@"pic"]){
        [self performSegueWithIdentifier:@"myShowPicView" sender:[NSNumber numberWithInteger:indexPath.row]];
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
       
        MyNote* mynote=[_TableViewListArray objectAtIndex:[indexPath row]];
        AppDelegate* myAppDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate] ;//获取委托
        [[myAppDelegate managedObjectContext] deleteObject:mynote];
        NSError *error;
        if (![[myAppDelegate managedObjectContext] save:&error]) {
            NSLog(@"Error:%@,%@",error,[error userInfo]);
        }
        else{
            NSLog(@"删除成功！");
            [_TableViewListArray removeObjectAtIndex:[indexPath row]];//删除数组中元素
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];

        }
            } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*@
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

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController* view = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"myShowTextView"]) {
        [view setValue:sender forKey:@"num"];
    }
        [view setValue:self forKey:@"param"];
}


@end
