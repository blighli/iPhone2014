//
//  EduTVC.m
//  final
//
//  Created by xuyouyang on 15/1/7.
//  Copyright (c) 2015年 zju-cst. All rights reserved.
//

#import "EduTVC.h"
#import "PostDetailVC.h"
#import "MJRefresh/MJRefresh.h"
#import "MRProgress.h"
#import "NetworkTool.h"
#import "Post.h"

@interface EduTVC ()

@property (nonatomic, strong)NSMutableArray *edu;

@end

@implementation EduTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NetworkTool *networkTool = [[NetworkTool alloc]init];
    [networkTool getPostWithType:@"edu" success:^(id responseData) {
        self.edu = responseData;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];;
        [alert show];
    }];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithCallback:^{
        [networkTool getPostWithType:@"edu" success:^(id responseData) {
            self.edu = responseData;
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        } failure:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];;
            [alert show];
        }];
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
    return [self.edu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Post *post = [self.edu objectAtIndex:indexPath.row];
    cell.textLabel.text = post.title;
    cell.detailTextLabel.text = post.publishTime;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = [self.edu objectAtIndex:indexPath.row];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PostDetailVC *postDetailViewControl = [segue destinationViewController];
    NSInteger index = [self.tableView indexPathForCell:(UITableViewCell *)sender].row;
    postDetailViewControl.post = [self.edu objectAtIndex:index];
}

@end
