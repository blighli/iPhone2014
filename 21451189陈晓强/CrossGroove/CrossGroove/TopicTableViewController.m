//
//  TopicTableViewController.m
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/23.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "TopicTableViewController.h"
#import "GrooveShow.h"
#import "AFNetworking.h"
#import "GrooveTableViewController.h"

@interface TopicTableViewController ()

@property (strong, nonatomic) NSMutableArray *grooveArray;
@property (nonatomic) NSUInteger *grooveCount;
@property (strong, nonatomic) NSMutableDictionary *idDict;
@end

@implementation TopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    _grooveArray = [NSMutableArray array];
    _idDict = [NSMutableDictionary dictionary];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://localhost:8080/Groose/main/topiclist.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        NSArray *topicArray = (NSArray *)responseObject;
        for(NSDictionary *dict in topicArray)
        {
//            NSLog(@"%@",[dict objectForKey:@"topicName"]);
            [self.grooveArray addObject:[dict objectForKey:@"topicName"]];
            
            NSString *key = [dict objectForKey:@"topicName"];
            NSString *myID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"topicID"]];
            [self.idDict setValue:myID forKey:key];
            NSLog(@"%@",[_idDict objectForKey:[dict objectForKey:@"topicName"]]);
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
}

- (IBAction)newGroove:(id)sender {
    GrooveShow *showGroove = [[GrooveShow alloc] initWithTitle:@"New Groove" cancleButtonTitle:@"Cancel" okButtonTitle:@"OK"];
    showGroove.delegate = self;
    [showGroove show];
}


#pragma mark - GrooveDelegate

- (void)grooveShow:(GrooveShow *)grooveShow andChangeTextField:(UITextField *)textField
{

    NSDictionary *parameters = @{@"topicname":textField.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://localhost:8080/Groose/main/inserttopic" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [self.grooveArray removeAllObjects];
        NSArray *topicArray = (NSArray *)responseObject;
        for(NSDictionary *dict in topicArray)
        {
            NSLog(@"%@",[dict objectForKey:@"topicName"]);
            [self.grooveArray addObject:[dict objectForKey:@"topicName"]];
        }
        [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.grooveArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize size = CGSizeMake(rect.size.width, 55.0f);
        return size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.textLabel.text = [self.grooveArray objectAtIndex:indexPath.row];
        UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
        [cell setBackgroundView:backImage];
    return cell;
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MyTableViewCell *cell = (MyTableViewCell *)sender;
    NSLog(@"%@",cell.textLabel.text);
    if([segue.destinationViewController isKindOfClass:[GrooveTableViewController class]])
    {
        
        GrooveTableViewController *grooveTVC = (GrooveTableViewController *)segue.destinationViewController;
        grooveTVC.topicName = cell.textLabel.text;
        grooveTVC.topicID = [_idDict objectForKey:cell.textLabel.text];
    }
}


@end
