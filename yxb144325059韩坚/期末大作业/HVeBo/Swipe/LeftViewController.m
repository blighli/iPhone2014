//
//  LeftViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/14.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "BaseTableViewController.h"
#import "BaseViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "HttpTool.h"
#import "User.h"
#import "LeftTableViewCell.h"
#import "SDImageCache.h"

@interface LeftViewController ()<LogEventDelegate>
{
    UIImageView *_icon;
    UIView *_iconView;
    UIView *_footView;
}
@property (nonatomic, weak) AppDelegate *myDelegate;
@property (nonatomic, strong)User *user;
@end

@implementation LeftViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     _myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    _myDelegate.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    self.view.backgroundColor = [UIColor darkGrayColor];
   _iconView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180 , 200)];
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50, 100, 100)];

    _icon.layer.masksToBounds = YES;
    _icon.layer.cornerRadius = 50;
    
    [_iconView addSubview:_icon];
    _iconView.backgroundColor = [UIColor darkGrayColor];
    
    _footView =  [[[NSBundle mainBundle] loadNibNamed:@"leftFootView" owner:self options:nil] lastObject];
    
    _clearBtn.showsTouchWhenHighlighted = YES;
    _clearBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [_clearBtn setTitle:[NSString stringWithFormat:@"清除图片缓存\n%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]] forState:UIControlStateNormal];
}
- (void)viewDidAppear:(BOOL)animated
{
    if (_user == nil) {
        _user  = _myDelegate.user;
        [HttpTool dowloadImage:_user.avatarLargeUrl iamgeview:_icon placeHolder:nil];
    }
}
- (void)login
{
    _user  = _myDelegate.user;
    [HttpTool dowloadImage:_user.avatarLargeUrl iamgeview:_icon placeHolder:nil];
    if ([_degetalte respondsToSelector:@selector(login)]) {
        [_degetalte login];
    }
    
}
- (void)startAction
{
    _user  = _myDelegate.user;
    [HttpTool dowloadImage:_user.avatarLargeUrl iamgeview:_icon placeHolder:nil];
    if ([_degetalte respondsToSelector:@selector(startAction)]) {
        [_degetalte startAction];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 160;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _iconView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _footView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= 4)
    {
        if ([_degetalte respondsToSelector:@selector(didSelectedFrature:)]) {
            [_degetalte didSelectedFrature:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }

    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= 4 || indexPath.row == 8) {
        return YES;
    }else{
        return NO;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:150/255 green:150/255 blue:150/255 alpha:0.3];
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
//    UISwitch *more = [[UISwitch alloc] initWithFrame:CGRectMake(120, 7, 0, 0)];
//    more.onTintColor = [UIColor blackColor];
//    [more addTarget:self action:@selector(moreSwitch:) forControlEvents:UIControlEventValueChanged];
//    more.on = YES;
//    UISwitch *hidden = [[UISwitch alloc] initWithFrame:CGRectMake(120, 7, 0, 0)];
//    hidden.onTintColor = [UIColor blackColor];
//    [hidden addTarget:self action:@selector(hiddenSwitch:) forControlEvents:UIControlEventValueChanged];
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"全部"; break;
        case 1:
            cell.textLabel.text = @"原创"; break;
        case 2:
            cell.textLabel.text = @"图片"; break;
        case 3:
            cell.textLabel.text = @"视频"; break;
        case 4:
            cell.textLabel.text = @"音乐"; break;
        case 5:
            cell.textLabel.text = @"---";break;
        case 6:
//            [cell addSubview:more];
//            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            cell.textLabel.text = @"自动加载更多";
//            break;
//        case 7:
//            [cell addSubview:hidden];
//            cell.textLabel.text = @"隐藏DOCK";
//            break;
//        case 8:
//            cell.textLabel.text = @"清空缓存";
//            cell.detailTextLabel.textColor = [UIColor whiteColor];
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",[[SDImageCache sharedImageCache] getSize]];
        default:
            break;
    }
    return cell;
}


- (IBAction)hiddenSwitch:(UISwitch *)sender {
    if ([_degetalte respondsToSelector:@selector(didSelectedHidenSwitch:)])
    {
        [_degetalte didSelectedHidenSwitch:[sender isOn]];
    }
}

- (IBAction)clearBtn:(UIButton *)sender {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
       [_clearBtn setTitle:[NSString stringWithFormat:@"清除图片缓存\n%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]] forState:UIControlStateNormal];
    }];
}

- (IBAction)loginBtn:(UIButton *)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

- (IBAction)logoutBtn:(UIButton *)sender {
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (myDelegate.wbtoken != nil) {
        [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:myDelegate withTag:@"user1"];
    }
}

- (IBAction)moreSwitch:(UISwitch *)sender {
    if ([_degetalte respondsToSelector:@selector(didSelectedMoreWitch:)]) {
        [_degetalte didSelectedMoreWitch:[sender isOn]];
    }
}
@end
