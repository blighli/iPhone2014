//
//  LeftMenuViewController.m
//  EasyCount
//
//  Created by yingxl1992 on 14/12/23.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideMenu/Animations/SlideNavigationContorllerAnimatorFade.h"
#import "SlideMenu/Animations/SlideNavigationContorllerAnimatorSlide.h"
#import "SlideMenu/Animations/SlideNavigationContorllerAnimatorScale.h"
#import "SlideMenu/Animations/SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideMenu/Animations/SlideNavigationContorllerAnimatorSlideAndFade.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = YES;
    
    return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundView = imageView;
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Expend";
            break;
            
        case 1:
            cell.textLabel.text = @"Income";
            break;
            
        case 2:
            cell.textLabel.text = @"CountPie";
            break;
            
        case 3:
            cell.textLabel.text = @"UserCenter";
            break;
            
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UIViewController *vc ;
    
    switch (indexPath.row)
    {
        case 0:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MainViewController"];
            break;
            
        case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"IncomeListViewController"];
            break;
            
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"CountTabViewController"];
            break;
            
        case 3:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InfoCenterViewController"];
            break;
    }
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];}@end
