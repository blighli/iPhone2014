//
//  MypictureTableViewController.m
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "MypictureTableViewController.h"
#import "PaintViewController.h"

@interface MypictureTableViewController ()

@end

@implementation MypictureTableViewController
@synthesize listData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *thumbAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail",NSHomeDirectory()];
    NSArray *filesNAme = [fileManage subpathsAtPath: thumbAPath];
    self.listData = filesNAme;
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
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableSampleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CellIdentifier];
    }
    NSUInteger row=[indexPath row];
    cell.textLabel.text=[listData objectAtIndex:row];
    //获取缩略图路径
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/thumbnail/%@",NSHomeDirectory(),[listData objectAtIndex:row]];
    //获取缩略图
    UIImage *image=[[UIImage alloc]initWithContentsOfFile:aPath];
    cell.imageView.image=image;
    //获取文件修改时间
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary* attributes = [fileManager attributesOfItemAtPath:aPath error:nil];
    NSDate *date = (NSDate*)[attributes objectForKey:NSFileModificationDate];
    NSString *dateText = [[NSString alloc] initWithFormat:@"%@",date];
    cell.detailTextLabel.text = dateText;
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"sendPicture" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"sendPicture"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *sendPictureName = [listData objectAtIndex:[indexPath row]];
        NSLog(@"66666666  %@",sendPictureName);
        PaintViewController *destViewController = segue.destinationViewController;
        if ([destViewController respondsToSelector:@selector(setSendPictureName:)]) {
            [destViewController setValue:sendPictureName forKey:@"sendPictureName"];
        }
    }
}

@end
