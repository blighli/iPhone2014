//
//  NewTVC.m
//  final
//
//  Created by xuyouyang on 14/12/15.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "NewsTVC.h"
#import "PostDetailVC.h"
#import "MJRefresh/MJRefresh.h"
#import "MRProgress.h"
#import "NetworkTool.h"
#import "Post.h"
#import "CycleScrollView.h"

@interface NewsTVC ()

@property (nonatomic, strong)NSMutableArray *news;

@end

@implementation NewsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NetworkTool *networkTool = [[NetworkTool alloc]init];
    [networkTool getPostWithType:@"news" success:^(id responseData) {
        self.news = responseData;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];;
        [alert show];
    }];

    // 添加顶部图片滚动栏
    CycleScrollView *scrollImageView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 180) animationDuration:2.0];
    scrollImageView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
//        UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScrollView_Image1"]];
        imageView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 180);
        return imageView;
    };
    scrollImageView.totalPagesCount =  ^NSInteger(void){
        return 1;
    };

    self.tableView.tableHeaderView = scrollImageView;
    
    // 添加下拉刷新控件
//    [self.tableView addHeaderWithCallback:^{
//        [networkTool getPostWithType:@"news" success:^(id responseData) {
//            self.news = responseData;
//            [self.tableView reloadData];
//            [self.tableView headerEndRefreshing];
//        } failure:^(NSError *error) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];;
//            [alert show];
//        }];
//    }];
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
    return [self.news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Post *post = [self.news objectAtIndex:indexPath.row];
    cell.textLabel.text = post.title;
    cell.detailTextLabel.text = post.publishTime;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = [self.news objectAtIndex:indexPath.row];
    NSString *title = post.title;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0]}];
    float lineNumber = titleSize.width / (self.view.frame.size.width - 40);
    // 一行
    if (lineNumber <= 1) {
        return 60;
    }
    // 两行
    if (lineNumber > 1 && lineNumber <= 2) {
        return 80;
    }
    // 三行
    return 100;
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
    postDetailViewControl.post = [self.news objectAtIndex:index];
}

@end
