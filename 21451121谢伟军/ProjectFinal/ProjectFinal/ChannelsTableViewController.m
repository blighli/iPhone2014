//
//  ChannelsTableViewController.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/21/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import "ChannelsTableViewController.h"

@interface ChannelsTableViewController (){
    AFHTTPRequestOperationManager *manager;
    AppDelegate *appDelegate;
    NetworkManager *networkManager;
}

@end

@implementation ChannelsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [AFHTTPRequestOperationManager manager];
    UINib *cell = [UINib nibWithNibName:@"ChannelsTableViewCell" bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:@"theReuseIdentifier"];
//    _channelsTitle = @[@"我的兆赫",@"推荐兆赫",@"热门兆赫",@"上升最快兆赫"];
    _channelsTitle = @[@"我的兆赫",@"热门兆赫"];
    _channels = [NSMutableArray array];
    //我的兆赫
    _myChannels = @[@"我的私人",@"我的红心"];
    _myPrivateChannel = [NSMutableArray array];
    [_channels addObject:_myChannels];
    _myRedheartChannel = [NSMutableArray array];
    _hotChannels = [NSMutableArray array];
    [_channels addObject:_hotChannels];
    _hotChannelInfo = [[ChannelInfo alloc]init];
    [self setHot_channels];
    [self setPlaylistwithChannelID:@"1"];
    //self.tableView.delegate = self;
    appDelegate = [[UIApplication sharedApplication]delegate];
    networkManager = [[NetworkManager alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [_channelsTitle count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[_channels objectAtIndex:section]count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_channelsTitle objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"theReuseIdentifier";
    ChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                            forIndexPath:indexPath];
//    if ([[_channels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] != nil) {
//        cell.textLabel.text = [[_channels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    }
//    else
//        cell.textLabel.text = @"1";
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[_channels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.textLabel.text = [[[_channels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]valueForKey:@"name"];
        default:
            
            break;
    }
    return cell;
}

#pragma mark - NET
-(void)setHot_channels{
    [manager GET:@"http://douban.fm/j/explore/hot_channels" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *hotChannelsDictionary = responseObject;
        NSLog(@"JSON: %@", hotChannelsDictionary);
        NSDictionary *tempChannel = [hotChannelsDictionary objectForKey:@"data"];
        for (NSDictionary *hotChannels in [tempChannel objectForKey:@"channels"]) {
            ChannelInfo *channelInfo = [[ChannelInfo alloc]init];
            [channelInfo setID:[hotChannels objectForKey:@"id"]];
            [channelInfo setName:[hotChannels objectForKey:@"name"]];
            [_hotChannels addObject:channelInfo];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)setPlaylistwithChannelID:(NSString *)ID{
    NSString *playlistUrl = @"http://douban.fm/j/mine/playlist?channel=";
    playlistUrl = [playlistUrl stringByAppendingString:ID];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:playlistUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    appDelegate.currentChannel = [[_channels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    NSLog(@"%@",appDelegate.currentChannel.ID);
//    [networkManager loadPlaylistwithType:@"n" Sid:nil];
    [networkManager loadPlaylistwithType:@"n" Sid:nil];
    // Push the view controller.
    //[self.navigationController pushViewController:detailViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
