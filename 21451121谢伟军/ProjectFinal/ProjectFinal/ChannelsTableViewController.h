//
//  ChannelsTableViewController.h
//  ProjectFinal
//
//  Created by xvxvxxx on 12/21/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelsTableViewCell.h"
#import "ChannelInfo.h"
#import <AFNetworking/AFNetworking.h>
@interface ChannelsTableViewController : UITableViewController
@property NSMutableArray *channels;
@property NSArray *channelsTitle;
@property NSArray *myChannels;
@property NSMutableArray *myPrivateChannel;
@property NSMutableArray *myRedheartChannel;
@property NSMutableArray *hotChannels;

@property ChannelInfo *hotChannelInfo;
-(void)setHot_channels;
-(void)setPlaylistwithChannelID:(NSString *)ID;
@end
