//
//  ChannelViewController.m
//  DoubanFM
//
//  Created by 陈聪荣 on 14/12/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "ChannelViewController.h"
#import "HttpController.h"
#import "DoubanChannel.h"
@implementation ChannelViewController{
    HttpController *controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _channelTableView.delegate = self;
    _channelTableView.dataSource = self;
    controller = [[HttpController alloc]init];
    _channelArray = [controller requestDoubanChannels];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView:)
                                                 name:@"reloadChannelView"
                                               object:nil];
    NSLog(@"view done load！");
}

-(void)reloadView:(NSNotification*)notification
{
    _channelArray = [notification object];
    [_channelTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)retunClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _channelArray.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channelCell"  forIndexPath:indexPath];
    NSDictionary* songDic = [_channelArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [songDic valueForKey:@"name"];
    
    NSString* channel_id = [NSString stringWithFormat:@"%@",[songDic valueForKey:@"channel_id"]];
    cell.detailTextLabel.text = channel_id;
    //cell.imageView = [UIImage imageNamed:@"defalut_song_image"];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *channelDic = [_channelArray objectAtIndex:indexPath.row];
    NSString *channelName = [channelDic valueForKey: @"name"];
    NSInteger channelId = [[channelDic valueForKey:@"channel_id"]intValue];
    DoubanChannel *channel = [[DoubanChannel alloc]initWithName:channelName andChannelId:channelId];
    [controller requestDoubanSongsWithChannel:channel.channel_id];
    NSLog(@"%d----%@",(int)channelId, channelName);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.25 animations: ^{
        cell.layer.transform=CATransform3DMakeScale(1, 1, 1);
    }];
}

@end
