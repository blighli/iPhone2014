//
//  ItemViewerViewController.m
//  RSSReader
//
//  Created by Mz on 14-12-17.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "ItemViewerViewController.h"
#import "RSSListViewController.h"
#import "DAO.h"
#import "SCLAlertView.h"

@interface ItemViewerViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) RSSListViewController *parent;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@end

@implementation ItemViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews{
    //[_webView loadHTMLString:[_parent currentItem].content baseURL:nil];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_parent currentItem].link]]];
    [_webView setScalesPageToFit:YES];
    [_prevButton setEnabled:[_parent hasPrev]];
    [_nextButton setEnabled:[_parent hasNext]];
}

- (IBAction)prevButtonPressed:(id)sender {
    [_parent selectPrev];
    [self setupViews];
}

- (IBAction)nextButtonPressed:(id)sender {
    [_parent selectNext];
    [self setupViews];
}

- (IBAction)favoriteButtonPressed:(id)sender {
    [DAO setItemFavorite:[_parent currentItem]];
    [self showSuccess:[_parent currentItem].title];
}

#pragma mark - Notice

- (void)showSuccess:(NSString *)message {
    SCLAlertView *notice = [[SCLAlertView alloc] init];
    [notice showSuccess:self.tabBarController
                  title:@"收藏成功"
               subTitle:message
       closeButtonTitle:@"确定"
               duration:0.0f];
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
