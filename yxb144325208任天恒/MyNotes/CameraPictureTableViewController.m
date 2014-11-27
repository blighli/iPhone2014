//
//  CameraPictureTableViewController.m
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "CameraPictureTableViewController.h"

@interface CameraPictureTableViewController ()

@end

@implementation CameraPictureTableViewController
@synthesize listData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *docsDir2;
    NSArray *dirPaths2;
    NSMutableArray *list2 = [[NSMutableArray alloc] initWithObjects:nil];
    // NSMutableArray *list2 = [[NSMutableArray alloc] initWithObjects:nil];
    
    // Get the documents directory
    dirPaths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir2 = [dirPaths2 objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir2 stringByAppendingPathComponent: @"camera.db"]];
    
    
    const char *dbpath = [databasePath UTF8String];
    NSLog(@"%@",databasePath);
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &cameraDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT PICTURE from camera "];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(cameraDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                {
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    [list2 addObject:name];
                }
                NSLog(@"已经查到结果");
                NSLog(@"%@",list2);
                
            }
            
        }
        
        sqlite3_close(cameraDB);
    }
    self.listData = list2;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.listData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellWithIdentifier = @"CameraCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.listData objectAtIndex:row];
    cell.detailTextLabel.text = @"详细信息";
    cell.accessoryType = UITableViewCellSelectionStyleGray;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"camera" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"camera"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *sendPictureName = [listData objectAtIndex:[indexPath row]];
        NSLog(@"图片名字为:%@",sendPictureName);
        PictureDetailViewController *pictureDetailViewController = segue.destinationViewController;
        
        if ([pictureDetailViewController respondsToSelector:@selector(setSendPictureName:)]) {
            [pictureDetailViewController setValue:sendPictureName forKey:@"sendPictureName"];
        }
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
