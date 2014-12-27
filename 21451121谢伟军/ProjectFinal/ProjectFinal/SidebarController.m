//
//  SidebarController.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/27/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import "SidebarController.h"

@interface SidebarController (){
    enum page{
        playerPage,playlistPage,loginPage
    } currentPage;
}

@end

@implementation SidebarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *imageList = @[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuClose.png"]];
    sideBar = [[CDSideBarController alloc] initWithImages:imageList];
    sideBar.delegate = self;
    
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    playerVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"playerVC"];
    channelsVC = [[ChannelsTableViewController alloc]init];
    channelsVC.delegate = (id)self;
    loginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginVC"];
    test = [[TestViewController alloc]init];
    self.viewControllers = @[playerVC, channelsVC, loginVC, test];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBar.hidden = YES;
    [sideBar insertMenuButtonOnView:self.view atPosition:CGPointMake(self.view.frame.size.width - 50, 40)];
}

#pragma mark - SDSidebar Delegate
-(void)menuButtonClicked:(int)index{
    self.selectedIndex = index;
//    switch (index) {
//        case 0:
//            //
//            self.selectedIndex = index;
//            break;
//        case 1:
//            //
//            self.selectedIndex = 1;
//            break;
//        case 2:
//
//        default:
//            break;
//    }
}

@end
