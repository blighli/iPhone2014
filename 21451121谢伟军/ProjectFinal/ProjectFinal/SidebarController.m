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
    
    playerVC = [[ViewController alloc]init];
    channelsVC = [[ChannelsTableViewController alloc]init];
    loginVC = [[LoginViewController alloc]init];
    
    self.viewControllers = @[channelsVC, loginVC];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBar.hidden = YES;
    
    //[sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 50, 40)];
        [sideBar insertMenuButtonOnView:self.view atPosition:CGPointMake(self.view.frame.size.width - 50, 40)];
//    self.tabBar.frame = CGRectMake(0, 460-40, 320, 40);
//    for (UIView *child in self.tabBar.subviews)
//    {
//        if ([child isKindOfClass:[UIControl class]])
//        {
//            [child removeFromSuperview];
//        }
//    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma SDSidebar Delegate
-(void)menuButtonClicked:(int)index{
    NSLog(@"%i",index);
    switch (index) {
        case 0:
            //
            self.selectedIndex = index;
            break;
        case 1:
            //
            self.selectedIndex = index;
            currentPage = index;
            break;
        case 2:
            if (currentPage != loginPage) {
                
            }
        default:
            break;
    }
}

@end
