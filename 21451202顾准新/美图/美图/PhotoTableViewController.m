//
//  PhotoTableViewController.m
//  美图
//
//  Created by 顾准新 on 14-12-18.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "PhotoTableViewController.h"
#import "PhotoViewController.h"
#import "Colours.h"
#import "SDImageCache.h"
#import "LBHamburgerButton.h"
#import "EBPhotoPagesController.h"
#import "EBPhotoPagesFactory.h"
#import "EBTagPopover.h"
#import "Reachability.h"
#import "AppInfoViewController.h"

#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width
#define kTopBarHeight           (44.f)

@interface PhotoTableViewController ()<EBPhotoPagesDataSource,EBPhotoPagesDelegate>
{
    NSMutableArray *_photos;
}
@property (nonatomic,strong) PhotoViewController *vc;
@property (nonatomic,strong) EBPhotoPagesController *photsPagesVC;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) Reachability *connect;

@end

@implementation PhotoTableViewController

- (void)leftButtonPressed{
    AppInfoViewController *appInfoVC = [[AppInfoViewController alloc] init];
    appInfoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:appInfoVC animated:YES completion:nil];
}

- (void)setAppInfoItem{
    CGFloat navRightBtn_w = 40.f;
    CGFloat navRightBtn_h = 30.f;
    CGFloat navRightBtn_x = App_Frame_Width - 10.f;
    CGFloat navRightBtn_y = (kTopBarHeight - navRightBtn_h) / 2.f;
    
    UIButton *navRightBtn = [[UIButton alloc] init];
    [navRightBtn setFrame:CGRectMake(navRightBtn_x,
                                     navRightBtn_y,
                                     navRightBtn_w,
                                     navRightBtn_h)];
    
    CGFloat plusIV_w = 30.f;
    CGFloat plusIV_h = 30.f;
    CGFloat plusIV_x = (navRightBtn.bounds.size.width - plusIV_w) / 2.f;
    CGFloat plusIV_y = (navRightBtn.bounds.size.height - plusIV_h) / 2.f;
    
    UIImageView *_plusIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"More"]];
    [_plusIV setFrame:CGRectMake(plusIV_x,
                                 plusIV_y,
                                 plusIV_w,
                                 plusIV_h)];
    
    [navRightBtn addSubview:_plusIV];
    
    [navRightBtn addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = self.navigationItem.leftBarButtonItem;
    leftItem.customView = navRightBtn;
}

- (void)setShowLoveItem{
    CGFloat navRightBtn_w = 40.f;
    CGFloat navRightBtn_h = 30.f;
    CGFloat navRightBtn_x = App_Frame_Width - 10.f;
    CGFloat navRightBtn_y = (kTopBarHeight - navRightBtn_h) / 2.f;
    
    UIButton *navRightBtn = [[UIButton alloc] init];
    [navRightBtn setFrame:CGRectMake(navRightBtn_x,
                                     navRightBtn_y,
                                     navRightBtn_w,
                                     navRightBtn_h)];
    
    CGFloat plusIV_w = 30.f;
    CGFloat plusIV_h = 30.f;
    CGFloat plusIV_x = (navRightBtn.bounds.size.width - plusIV_w) / 2.f;
    CGFloat plusIV_y = (navRightBtn.bounds.size.height - plusIV_h) / 2.f;
    
     UIImageView *_plusIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"love"]];
    [_plusIV setFrame:CGRectMake(plusIV_x,
                                 plusIV_y,
                                 plusIV_w,
                                 plusIV_h)];
    
    [navRightBtn addSubview:_plusIV];
    
    [navRightBtn addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = self.navigationItem.rightBarButtonItem;
    rightItem.customView = navRightBtn;
    
}

-(void)initData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"myLove.plist"];
    _photos= [[NSMutableArray alloc] initWithContentsOfFile:namePath];
}

- (void)rightButtonPressed:(UIButton *)sender
{
    [self initData];
    
    if(_photos.count){
    
        _photsPagesVC = [[EBPhotoPagesController alloc]initWithDataSource:self delegate:self];
        _photsPagesVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:_photsPagesVC animated:YES completion:nil];
    }else{
        UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"亲！" message:@"您还未收藏任何图片！" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f
                                         target:self
                                       selector:@selector(timerFireMethod:)
                                       userInfo:promptAlert
                                        repeats:YES];
        [promptAlert show];
        return;

        
        
    }
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

-(NSArray *)titles{
    if(!_titles){
        _titles = [[NSArray alloc]initWithObjects:@"动漫",@"美食",@"设计",@"汽车",@"宠物",@"摄影",@"美女",@"婚嫁", nil];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor waveColor];
    [self setShowLoveItem];
    
    [self setAppInfoItem];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor waveColor]}];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkState) name:kReachabilityChangedNotification object:nil];
    self.connect = [Reachability reachabilityForInternetConnection];
    [self.connect startNotifier];
}

- (void)checkNetworkState{
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    if([wifi currentReachabilityStatus] != NotReachable){
        
    }else if ([conn currentReachabilityStatus] != NotReachable){
   
    }else{
        UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"亲！" message:@"您还未连接网络" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f
                                         target:self
                                       selector:@selector(timerFireMethod:)
                                       userInfo:promptAlert
                                        repeats:YES];
        [promptAlert show];
        return;
    }
    
    
    
}

- (void)dealloc{
    [self.connect stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.height/[_titles count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    cell.backgroundColor = [UIColor blueberryColor];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat: @"%ld.png",(long)indexPath.row]];
    
    cell.textLabel.text = _titles[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"details"]){
        _vc = (PhotoViewController *)segue.destinationViewController;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _vc.index1 = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    _vc.tag1 = _titles[indexPath.row];
}


#pragma mark - EBPhotoPagesDataSource

-(BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController shouldExpectPhotoAtIndex:(NSInteger)index{
    if(index < _photos.count){
        return YES;
    }
    return  NO;
}

-(void)photoPagesController:(EBPhotoPagesController *)controller imageAtIndex:(NSInteger)index completionHandler:(void (^)(UIImage *))handler{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[_photos[index] objectForKey:@"image_url"]]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        UIImage *image = [UIImage imageWithData:data];
        handler(image);
    });
}

-(void)photoPagesController:(EBPhotoPagesController *)controller captionForPhotoAtIndex:(NSInteger)index completionHandler:(void (^)(NSString *))handler{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        handler([[_photos objectAtIndex:index]objectForKey:@"desc"]);
    });
}

-(void)photoPagesController:(EBPhotoPagesController *)photoPagesController didDeletePhotoAtIndex:(NSInteger)index{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"myLove.plist"];
    NSMutableArray *picArray = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
    
    [_photos removeObjectAtIndex:index];
    [picArray removeObjectAtIndex:index];
    
    [picArray writeToFile:namePath atomically:YES];
    
    //[self.photsPagesVC reloadInputViews];
    
}

- (BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController shouldAllowTaggingForPhotoAtIndex:(NSInteger)index{
    return NO;
}

- (BOOL)photoPagesController:(EBPhotoPagesController *)controller
 shouldAllowDeleteForComment:(id<EBPhotoCommentProtocol>)comment
             forPhotoAtIndex:(NSInteger)index{

    return NO;
}


- (BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController shouldAllowCommentingForPhotoAtIndex:(NSInteger)index{
    return NO;
}


- (BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController shouldAllowActivitiesForPhotoAtIndex:(NSInteger)index{
    return YES;
}

- (BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController shouldAllowMiscActionsForPhotoAtIndex:(NSInteger)index{
    return YES;
}

- (BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController shouldAllowDeleteForPhotoAtIndex:(NSInteger)index{
    return YES;
}


- (BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController
     shouldAllowDeleteForTag:(EBTagPopover *)tagPopover
              inPhotoAtIndex:(NSInteger)index{
    return NO;
}


- (BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController
    shouldAllowEditingForTag:(EBTagPopover *)tagPopover
              inPhotoAtIndex:(NSInteger)index{
    return NO;
}


- (BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController shouldAllowReportForPhotoAtIndex:(NSInteger)index{
    return NO;
}

@end
