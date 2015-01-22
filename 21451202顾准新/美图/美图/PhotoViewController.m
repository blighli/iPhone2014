//
//  PhotoViewController.m
//  美图
//
//  Created by 顾准新 on 14-12-18.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "PhotoViewController.h"
#import "SVPullToRefresh.h"
#import "LBHamburgerButton.h"
#import "Colours.h"

@interface PhotoViewController (){
    BOOL firstInit;
    int nowPage;
    int nowCount;
    MJRefreshFooterView *footer;
    MJRefreshHeaderView *header;
        
    UIImageView *clickImage;
    UIImageView *_plusIV;
        
    BOOL isRefresh_;
}

@property (nonatomic,retain) SidebarViewController * sidebarVC;
@property (nonatomic,strong) NSMutableDictionary *testDic;
@property (nonatomic,strong) NSMutableArray *testArr;
@property (nonatomic,strong) LBHamburgerButton* hamburgerColseButton;

@end

@implementation PhotoViewController
@synthesize testRequest;
@synthesize testArr;
@synthesize testDic;
@synthesize index1;
@synthesize index2;

- (void)initWaterViewBlock{
    __weak  UIImageView *clickImageSelf = clickImage;
    __weak PhotoViewController *weakSelf = self;
    self.waterView.didShowImage = ^(ImageInfo *data){
        NSURL *url = [NSURL URLWithString:data.thumbURL];
        [clickImageSelf setImageWithURL:url placeholderImage:nil];
        TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:clickImageSelf.image setImageInfo:data];
        viewController.transitioningDelegate = weakSelf;
        [weakSelf presentViewController:viewController animated:YES completion:nil];
    };
    
    __weak NSMutableArray *testArrWeak = testArr;
    self.waterView.didCancelImage = ^(ImageInfo *data){
        
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您是否确定要删除该图片" leftButtonTitle:@"是" rightButtonTitle:@"否"];
        [alert show];
        alert.leftBlock = ^()
        {
            [testArrWeak removeObject:data];
            
            __weak PhotoViewController *blockSelf = weakSelf;
            [blockSelf.waterView refreshView:testArrWeak];
            [blockSelf.waterView.infiniteScrollingView stopAnimating];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString * namePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"savedPicInfo_%@%@.plist",weakSelf.index1,weakSelf.index2]];
            NSMutableArray *picArray = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
            
            for (int i=0; i<[picArray count]; i++)
            {
                if ([[[picArray objectAtIndex:i]objectForKey:@"image_url"] isEqualToString:data.thumbURL])
                {
                    [picArray removeObjectAtIndex:i];
                    break;
                }
            }
            [picArray writeToFile:namePath atomically:YES];
            
        };
        alert.rightBlock = ^()
        {
        };
        alert.dismissBlock = ^()
        {
        };
    
    };
}
- (void)initWallView
{
    [self.waterView removeFromSuperview];
    [footer free];
    [header free];
    self.testArr = [[NSMutableArray alloc]init];
    clickImage = [[UIImageView alloc]init];
    clickImage.contentMode = UIViewContentModeScaleAspectFill;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * namePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"savedPicInfo_%@%@.plist",index1,index2]];
    
    NSMutableArray *picArr = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
    
    nowCount = 0;
    nowPage = 1;
    
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory2 = [paths2 objectAtIndex:0];
    NSString * namePath2 = [documentsDirectory2 stringByAppendingPathComponent:@"myLove.plist"];
    NSMutableArray *picArray2 = [[NSMutableArray alloc] initWithContentsOfFile:namePath2];
    
    NSMutableArray *nowArr = [[NSMutableArray alloc]init];

    if (picArr)
    {
        nowCount = (int)[picArr count];
        nowPage = nowPage/30;
        for (int i=0; i<12; i++)
        {
            NSMutableDictionary *dataD =[[NSMutableDictionary alloc] initWithDictionary:[picArr objectAtIndex:i]];
            if (dataD)
            {
                
                for(NSDictionary *dic in picArray2){
                    if([[dic objectForKey:@"image_url"] isEqualToString:[dataD objectForKey:@"image_url"]]){
                        [dataD removeObjectForKey:@"love"];
                        [dataD setValue:@"YES" forKey:@"love"];
                    }
                }

                NSDictionary *dataDic = dataD;
                ImageInfo *imageInfo = [[ImageInfo alloc]initWithDictionary:dataDic];
                [testArr addObject:imageInfo];
                [nowArr addObject:imageInfo];
                nowCount++;
            }
        }
    }
    else
    {
        NSString* urlString = [NSString stringWithFormat:@"http:/image.baidu.com/channel/listjson?pn=%d&rn=12&tag1=%@&tag2=%@", nowPage, _tag1,_tag2];
        nowPage++;
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        self.testDic = [responseString objectFromJSONString];
        
        NSArray *array = [testDic objectForKey:@"data"];
        picArr = [[NSMutableArray alloc]initWithArray:array];
        

        for (int i=0; i<[array count]-1; i++)
        {
            NSMutableDictionary *nowDic = [[NSMutableDictionary alloc]init];
            [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"image_url"] forKey:@"image_url"];
            [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"image_width"] forKey:@"image_width"];
            [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"image_height"] forKey:@"image_height"];
            [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"desc"] forKey:@"desc"];
            [nowDic setObject:@"NO" forKey:@"love"];
            
            [picArr addObject:nowDic];
 
            NSDictionary *dataD = nowDic;
            if (dataD)
            {
                ImageInfo *imageInfo = [[ImageInfo alloc]initWithDictionary:dataD];
                
                if (imageInfo.thumbURL.length > 8)
                {
                    [testArr addObject:imageInfo];
                    [nowArr addObject:imageInfo];
                    nowCount++;
                }
            }
        }
        
        [picArr writeToFile:namePath atomically:YES];
    }
    CGFloat originY = firstInit ? 0 : 44;
    firstInit = NO;
    self.waterView = [[ImageWaterView alloc]initWithDataArray:testArr withFrame:CGRectMake(0, originY, 320, Screen_height)];
    
    [self initWaterViewBlock];
    //self.waterView.delegate = self;
    [self.view addSubview:self.waterView];
    
    footer = [MJRefreshFooterView footer];
    footer.scrollView = self.waterView;
    footer.delegate = self;
    
    header = [MJRefreshHeaderView header];
    header.scrollView = self.waterView;
    header.delegate = self;

    [self.view sendSubviewToBack:self.waterView];
}

-(void)myRefreshLogic
{
    [self.waterView removeFromSuperview];
    //注销与waterView绑定的KVO
    [header free];
    [footer free];
    
    self.testArr = [[NSMutableArray alloc]init];
    clickImage = [[UIImageView alloc]init];
    clickImage.contentMode = UIViewContentModeScaleAspectFill;
    
    nowCount = 0;
    nowPage = 1;
    
    nowPage = arc4random() % 20;
    
    NSString* urlString = [NSString stringWithFormat:@"http://image.baidu.com/channel/listjson?pn=%d&rn=10&tag1=%@&tag2=%@", nowPage,_tag1,_tag2];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    self.testDic = [responseString objectFromJSONString];
    
    NSArray *array = [testDic objectForKey:@"data"];
    NSMutableArray *picArr = [[NSMutableArray alloc]initWithArray:array];
    
    NSMutableArray *nowArr = [[NSMutableArray alloc]init];

    for (int i=0; i<[array count]-1; i++)
    {
        NSMutableDictionary *nowDic = [[NSMutableDictionary alloc]init];
        [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"image_url"] forKey:@"image_url"];
        [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"image_width"] forKey:@"image_width"];
        [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"image_height"] forKey:@"image_height"];
        [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"desc"] forKey:@"desc"];
        [nowDic setObject:@"NO" forKey:@"love"];
        
        [picArr addObject:nowDic];
        NSDictionary *dataD = nowDic;
        if (dataD)
        {
            ImageInfo *imageInfo = [[ImageInfo alloc]initWithDictionary:dataD];
            
            if (imageInfo.thumbURL.length > 8)
            {
                [testArr addObject:imageInfo];
                [nowArr addObject:imageInfo];
                nowCount++;
            }
        }
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * namePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"savedPicInfo_%@%@.plist",index1,index2]];
    [picArr writeToFile:namePath atomically:YES];
    
    self.waterView = [[ImageWaterView alloc]initWithDataArray:testArr withFrame:CGRectMake(0, 44, 320, Screen_height-44)];
    
    [self initWaterViewBlock];
    //self.waterView.delegate = self;
    [self.view addSubview:self.waterView];
    
    footer = [MJRefreshFooterView footer];
    footer.scrollView = self.waterView;
    footer.delegate = self;
    
    header = [MJRefreshHeaderView header];
    header.scrollView = self.waterView;
    header.delegate = self;
    
    [self.waterView refreshView:testArr];
    
    [self.view sendSubviewToBack:self.waterView];
    
    isRefresh_ = true;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setupSideBar{
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [panGesture delaysTouchesBegan];
    [self.view addGestureRecognizer:panGesture];
    
    self.sidebarVC = [[SidebarViewController alloc] init];
    [self.sidebarVC setBgRGB:0x000000];
    [self.view addSubview:self.sidebarVC.view];
    self.sidebarVC.view.frame  = self.view.bounds;
    
    self.sidebarVC.tag = _tag1;
    self.sidebarVC.index = index1;
    self.sidebarVC.delegate = self;
}

-(void)setTag2:(NSString *)tag2{
    _tag2 = tag2;
    self.navigationItem.title = [NSString stringWithFormat:@"%@&%@", _tag1,_tag2];
    [self initWallView];
}



-(void)setRightBarItem{
    _hamburgerColseButton = [[LBHamburgerButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)
                                                   withHamburgerType:LBHamburgerButtonTypeCloseButton
                                                           lineWidth:20
                                                          lineHeight:20/6
                                                         lineSpacing:2
                                                          lineCenter:CGPointMake(25, 25)
                                                               color:[UIColor waveColor]];
    [_hamburgerColseButton setBackgroundColor:[UIColor clearColor]];
    [_hamburgerColseButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = self.navigationItem.rightBarButtonItem;
    right.customView = _hamburgerColseButton;
}

-(void)buttonPressed:(LBHamburgerButton *)sender{
    LBHamburgerButton* btn = (LBHamburgerButton*)sender;
    

    [self.sidebarVC showHideSidebar];
    
    [btn switchState];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tag2 = @"全部";
    index2  = @"0";
    isRefresh_ = false;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@&%@", _tag1,_tag2];
    
    [self setRightBarItem];
    
    self.testArr = [[NSMutableArray alloc]init];
    clickImage = [[UIImageView alloc]init];
    clickImage.contentMode = UIViewContentModeScaleAspectFill;
 
    firstInit = YES;
    
    [self initWallView];

    
    [self setupSideBar];
}

-(void)panDetected:(UIPanGestureRecognizer *)recoginzer{
    [self.sidebarVC panDetected:recoginzer];

}


-(void)changeState{
    if (self.sidebarVC.isSidebarShown && _hamburgerColseButton.hamburgerState != LBHamburgerButtonStateNotHamburger) {
        [_hamburgerColseButton switchState];
    }
    if(!self.sidebarVC.isSidebarShown && _hamburgerColseButton.hamburgerState != LBHamburgerButtonStateHamburger){
        [_hamburgerColseButton switchState];
    }
}


- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]])
    {
        [self myRefreshLogic];
    }
    else
    {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"myLove.plist"];
    NSMutableArray *picArray = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
    

    
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory2 = [paths2 objectAtIndex:0];
    NSString * namePath2 = [documentsDirectory2 stringByAppendingPathComponent:[NSString stringWithFormat:@"savedPicInfo_%@%@.plist",_tag1,_tag2]];
    NSMutableArray *picArr = [[NSMutableArray alloc] initWithContentsOfFile:namePath2];
    
    for (int i =(int)([picArr count]-1); i>=0; i--)
    {
        for (int j=0; j<i; j++)
        {
            if ([[[picArr objectAtIndex:i]objectForKey:@"image_url"]isEqualToString:[[picArr objectAtIndex:j]objectForKey:@"image_url"]])
            {
                [picArr removeObjectAtIndex:i];
                break;
            }
        }
    }

    if (nowCount + 8 < [picArr count])
    {
        NSMutableArray *nowArr = [[NSMutableArray alloc]init];
        for (int i=nowCount; i<nowCount+8; i++)
        {
            NSMutableDictionary *dataD =[[NSMutableDictionary alloc] initWithDictionary:[picArr objectAtIndex:i]];
            if (dataD)
            {
                if ([picArray containsObject:dataD]) {
                    [dataD removeObjectForKey:@"love"];
                    [dataD setValue:@"YES" forKey:@"love"];
                }
                NSDictionary *dataDic = dataD;
                ImageInfo *imageInfo = [[ImageInfo alloc]initWithDictionary:dataDic];
                [testArr addObject:imageInfo];
                [nowArr addObject:imageInfo];
            }
        }
        nowCount+=8;
        
        __weak PhotoViewController *blockSelf = self;
        [blockSelf.waterView loadNextPage:nowArr];
        [blockSelf.waterView.infiniteScrollingView stopAnimating];
    }
    else
    {
        nowPage+=30;
        NSString* urlString = [NSString stringWithFormat:@"http://image.baidu.com/channel/listjson?pn=%d&rn=10&tag1=%@&tag2=%@", nowPage,_tag1,_tag2];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        testRequest = [ASIHTTPRequest requestWithURL:url];
        [testRequest setDelegate:self];
        [testRequest startAsynchronous];
    }
    }
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
}



#pragma mark - UIViewControllerTransitioningDelegate methods
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if ([presented isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:clickImage];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:clickImage];
    }
    return nil;
}

//-(void)showImage:(ImageInfo*)data
//{
//    NSURL *url = [NSURL URLWithString:data.thumbURL];
//    [clickImage setImageWithURL:url placeholderImage:nil];
//    TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:clickImage.image setImageInfo:data];
//    viewController.transitioningDelegate = self;
//    [self presentViewController:viewController animated:YES completion:nil];
//}


//-(void)removeImage:(ImageInfo*)data
//{
//    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您是否确定要删除该图片" leftButtonTitle:@"是" rightButtonTitle:@"否"];
//    [alert show];
//    alert.leftBlock = ^()
//    {
//        [testArr removeObject:data];
//       
//        __weak PhotoViewController *blockSelf = self;
//        [blockSelf.waterView refreshView:testArr];
//        [blockSelf.waterView.infiniteScrollingView stopAnimating];
//        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString * namePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"savedPicInfo_%@%@.plist",index1,index2]];
//        NSMutableArray *picArray = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
//        
//        for (int i=0; i<[picArray count]; i++)
//        {
//            if ([[[picArray objectAtIndex:i]objectForKey:@"image_url"] isEqualToString:data.thumbURL])
//            {
//                [picArray removeObjectAtIndex:i];
//                break;
//            }
//        }
//        [picArray writeToFile:namePath atomically:YES];
//        
//    };
//    alert.rightBlock = ^()
//    {
//    };
//    alert.dismissBlock = ^()
//    {
//    };
//}

//- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
//{
//}
//
//- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
//{
//}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    [refreshView endRefreshing];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSMutableArray *nowArr = [[NSMutableArray alloc]init];
    
    NSData *responseData = [request responseData];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    self.testDic = [responseString objectFromJSONString];
    
    NSArray *array = [testDic objectForKey:@"data"];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * namePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"savedPicInfo_%@%@.plist",index1,index2]];
    NSMutableArray *picArray = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
    
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory2 = [paths2 objectAtIndex:0];
    NSString * namePath2 = [documentsDirectory2 stringByAppendingPathComponent:@"myLove.plist"];
    NSMutableArray *picArr = [[NSMutableArray alloc] initWithContentsOfFile:namePath2];
    
    if (picArray == NULL)
    {
        picArray = [[NSMutableArray alloc]initWithArray:array];
    }

    for (int i=0; i<[array count]; i++)
    {
        if ( ![picArray containsObject:[array objectAtIndex:i]])
        {
            NSMutableDictionary *nowDic = [[NSMutableDictionary alloc]init];
            [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"image_url"] forKey:@"image_url"];
            [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"image_width"] forKey:@"image_width"];
            [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"image_height"] forKey:@"image_height"];
            [nowDic setObject:[[array objectAtIndex:i]objectForKey:@"desc"] forKey:@"desc"];
            [nowDic setObject:@"NO" forKey:@"love"];

            [picArray addObject:nowDic];
            NSMutableDictionary *dataD = nowDic;
            if (dataD)
            {
                if([picArr containsObject:dataD]){
                    [dataD setObject:@"YES" forKey:@"love"];
                }
                
                ImageInfo *imageInfo = [[ImageInfo alloc]initWithDictionary:dataD];
                
                if (imageInfo.thumbURL.length > 8)
                {
                    [testArr addObject:imageInfo];
                    [nowArr addObject:imageInfo];
                    nowCount++;
                }
            }
        }
    }
    [picArray writeToFile:namePath atomically:YES];
    
    __weak PhotoViewController *blockSelf = self;
    [blockSelf.waterView loadNextPage:nowArr];
    [blockSelf.waterView.infiniteScrollingView stopAnimating];
    

}


- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"系统繁忙, 请稍后重试"  delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:1.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
    
    if (isRefresh_)
    {
        [self initWallView];
        
        isRefresh_ = false;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    [footer free];
    [header free];
}
#pragma mark - Navigation




@end
