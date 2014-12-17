//
//  NewTVC.m
//  final
//
//  Created by xuyouyang on 14/12/15.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "NewsTVC.h"
#import "AFHTTPRequestOperationManager.h"
#import "PostDetailVC.h"
#import "PostCell.h"
#import "MJRefresh/MJRefresh.h"

@interface NewsTVC ()
@property (nonatomic, strong)NSMutableDictionary *news;
@property (nonatomic, strong)UILabel *label;
@end

@implementation NewsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type": @"news"};
    [manager GET:@"http://crawler-cst.herokuapp.com/post" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.news = responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithCallback:^{
        NSLog(@"刷新中");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self.news objectForKey:@"posts"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    cell.postTitle.text = [[[self.news objectForKey:@"posts"] objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.publishTime.text = [[[self.news objectForKey:@"posts"] objectAtIndex:indexPath.row] valueForKey:@"publish_time"];
//    cell.postTitle.text = [[[self.news objectForKey:@"posts"] objectAtIndex:indexPath.row] valueForKey:@"title"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
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
    PostDetailVC *postDetailViewControl = [segue destinationViewController];
    NSInteger index = [self.tableView indexPathForCell:(UITableViewCell *)sender].row;
    postDetailViewControl.post = [[self.news objectForKey:@"posts"] objectAtIndex:index];
}

@end
