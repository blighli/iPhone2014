//
//  MSaveTableViewController.m
//  Mynotes
//
//  Created by lixu on 14/11/16.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import "MSaveTableViewController.h"

@interface MSaveTableViewController ()


@property (strong, nonatomic) NSMutableArray *datasArray;

@end

@implementation MSaveTableViewController
@synthesize datasArray;

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MDBAccess *dbacess=[[MDBAccess alloc] init];
    [dbacess initializeDatabase];
    datasArray=[dbacess getAllDatas];
    [dbacess closeDatabase];
    NSLog(@"%@",datasArray);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [datasArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    Datas *datas=[datasArray objectAtIndex:[indexPath row]];
    cell.textLabel.text=datas.Name;
    cell.detailTextLabel.text=datas.Time;
    
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Datas *datas=[datasArray objectAtIndex:[indexPath row]];
//    [self performSegueWithIdentifier:@"saveDetailSegue" sender:datas];
    MDetailViewController *detailViewController=[[MDetailViewController alloc ] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    Datas *datas=[datasArray objectAtIndex:indexPath.row];
    detailViewController.datas=datas;
            
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld++++++++++++++++++",(long)[indexPath row]);
        MDBAccess *access=[[MDBAccess alloc] init];
        [datasArray removeObjectAtIndex:indexPath.row];
        [access initializeDatabase];
        [access deleteDatas:(int)indexPath.row];
        [access closeDatabase];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }   
}


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
