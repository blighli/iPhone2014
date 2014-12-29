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
    PlayerController *playerController;
}

@end

@implementation ChannelsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 84;
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor redColor];
    //初始化工具类
    appDelegate = [[UIApplication sharedApplication]delegate];
    networkManager = [[NetworkManager alloc]init];
    networkManager.delegate = self;
    playerController = [[PlayerController alloc]init];
    //初始化tableviewCell
    UINib *cell = [UINib nibWithNibName:@"ChannelsTableViewCell" bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:@"theReuseIdentifier"];

}

-(void)viewWillAppear:(BOOL)animated{
    if (appDelegate.isLogin) {
        [networkManager setChannel:1 withURLWithString:@"http://douban.fm/j/explore/get_login_chls?uk=4391875"];
    }
    else{
        [networkManager setChannel:1 withURLWithString:@"http://douban.fm/j/explore/get_recommend_chl"];
    }
    [networkManager setChannel:2 withURLWithString:@"http://douban.fm/j/explore/up_trending_channels"];
    [networkManager setChannel:3 withURLWithString:@"http://douban.fm/j/explore/hot_channels"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [appDelegate.channelsTitle count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[appDelegate.channels objectAtIndex:section]count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [appDelegate.channelsTitle objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"theReuseIdentifier";
    ChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[[appDelegate.channels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]valueForKey:@"name"];
    return cell;
}

#pragma mark - NET
//-(void)setChannel:(NSUInteger)channelIndex withURLWithString:(NSString *)urlWithString{
//    [manager GET:urlWithString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *channelsDictionary = responseObject;
//        NSLog(@"JSON: %@", channelsDictionary);
//        NSDictionary *tempChannel = [channelsDictionary objectForKey:@"data"];
//        if (channelIndex != 1) {
//            for (NSDictionary *channels in [tempChannel objectForKey:@"channels"]) {
//                ChannelInfo *channelInfo = [[ChannelInfo alloc]init];
//                [channelInfo setID:[channels objectForKey:@"id"]];
//                [channelInfo setName:[channels objectForKey:@"name"]];
//                [[_channels objectAtIndex:channelIndex] addObject:channelInfo];
//            }
//        }
//        else{
//            NSDictionary *channels = [tempChannel objectForKey:@"res"];
//                ChannelInfo *channelInfo = [[ChannelInfo alloc]init];
//                [channelInfo setID:[channels objectForKey:@"id"]];
//                [channelInfo setName:[channels objectForKey:@"name"]];
//                [[_channels objectAtIndex:channelIndex] addObject:channelInfo];
//        }
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    appDelegate.currentChannel = [[appDelegate.channels objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    NSLog(@"%@",appDelegate.currentChannel.ID);
    [networkManager loadPlaylistwithType:@"n"];
    [self.delegate menuButtonClicked:0];

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
- (void)reloadTableviewData{
    [self.tableView reloadData];
}
@end
