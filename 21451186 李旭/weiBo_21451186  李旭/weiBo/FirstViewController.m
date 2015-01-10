//
//  FirstViewController.m
//  weiBo
//
//  Created by lixu on 15/1/9.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()


@end

@implementation FirstViewController
NSInteger viewId=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    //slideSwitchView初始化设置
    self.slideSwitchView.slideSwitchViewDelegate=self;
    
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"] forState:UIControlStateNormal];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
    rightSideButton.frame = CGRectMake(0, 0, 20.0f, 44.0f);
    rightSideButton.userInteractionEnabled = NO;
    self.slideSwitchView.rigthSideButton = rightSideButton;
    
    self.publicView=[[PublicViewController alloc] init];
    self.publicView.title=@"微博广场";
    self.friendView=[[FriendViewController alloc] init];
    self.friendView.title=@"我的关注";
    self.mineView=[[MineViewController alloc] init];
    self.mineView.title=@"我的微博";
    self.herView=[[HerViewController alloc] init];
    self.herView.title=@"她的微博";
    
    [self.slideSwitchView buildUI];//初始化界面，调用delegate
    
    self.navigationBar.bounds=CGRectMake(0, 0, 320, 64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 滑动tab视图代理方法
-(NSUInteger) numberOfTab:(SUNSlideSwitchView *)view{
    return 4;
}

-(UIViewController*) slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number{
    switch (number) {
        case 0:
            return self.publicView;
            break;
        case 1:
            return self.friendView;
            break;
        case 2:
            return self.mineView;
            break;
        case 3:
            return self.herView;
            break;
            
        default:
            return nil;
            break;
    }
    
}
-(void) slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number{
    viewId=number;
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
