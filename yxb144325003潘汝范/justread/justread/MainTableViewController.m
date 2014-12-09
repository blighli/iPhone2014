//
//  MainTableViewController.m
//  justread
//
//  Created by Van on 14/12/5.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "MainTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"
#import "DetailViewController.h"
#import "SettingTableViewController.h"
#import "FavTableViewController.h"

@interface MainTableViewController ()

@property (nonatomic) Stories *story;
@property (nonatomic) NSMutableArray *storyArrary;
@property (nonatomic) NSArray *allStoryArrary;
@property (nonatomic) NSString *date;
@property (readwrite, nonatomic, strong) UIRefreshControl *refreshControl;
@property NSManagedObjectContext *managedObjectContext;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(refrash)
                                                name:@"refrash"//消息名
                                              object:nil];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"night"]){
        //night mode
        self.navigationController.navigationBar.barStyle =UIBarStyleBlack;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.view.backgroundColor = [self stringToColor:@"#343434"];
    }else{
        self.navigationController.navigationBar.barStyle =UIBarStyleDefault;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        self.navigationController.navigationBar.tintColor =[self.navigationController.navigationBar tintColor];
        self.view.backgroundColor = [UIColor whiteColor];
    }

    
    UIBarButtonItem *favoritesBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain  target:self action:@selector(tapFavorites)];
    favoritesBarButtonItem.style = UIBarButtonItemStylePlain;
    UIBarButtonItem *settingBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(tapSetting)];
    settingBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItems = @[settingBarButtonItem,favoritesBarButtonItem];
    self.title =@"今日热文";
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(fetchJson) forControlEvents:UIControlEventValueChanged];
    [self.mainTableview.tableHeaderView addSubview:self.refreshControl];
    self.tableView.rowHeight = 70.0f;
    [self showSplash];
    [self fetchJson];
    [self querySplash];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.allStoryArrary count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Stories *story = [self.allStoryArrary objectAtIndex:indexPath.row];
  //  [self.mainTableview registerClass: [ZhiTableViewCell class] forCellReuseIdentifier:@"zhihucell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zhihucell" forIndexPath:indexPath];
    [cell.textLabel setText:story.title];
    [cell.textLabel setNumberOfLines:2];
    NSURL *url = [NSURL URLWithString: story.images[0]];
    if (![story.images[0] isEqualToString:@""]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIImage *placeholderImage = [UIImage imageNamed:@"icon"];
        [cell.imageView setImage:placeholderImage];
        __weak UITableViewCell *weakCell = cell;
        
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:placeholderImage
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           
                                           weakCell.imageView.image = image;
                                           [weakCell setNeedsLayout];
                                           
                                       } failure:nil];
    }else{
         UIImage *placeholderImage = [UIImage imageNamed:@"icon"];
        [cell.imageView setImage:placeholderImage];
        [cell setNeedsLayout];
    }

    if (indexPath.row == [self.allStoryArrary count] - 1) {
        [self loadMoreData];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"night"]){
        //night mode
        cell.backgroundColor = [self stringToColor:@"#343434"];
        cell.textLabel.textColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Stories *story = [self.allStoryArrary objectAtIndex:indexPath.row];
    DetailViewController *Controller = [[self storyboard]instantiateViewControllerWithIdentifier:@"detail"];
    Controller.story = story;
    Controller.isFaved =[self serachWith:story];
    [self.navigationController showViewController:Controller sender:nil];

}
- (void) fetchJson{
    NSURLSessionDataTask *task = [self getDataFrom:@"http://news-at.zhihu.com/api/3/news/latest"];
    [task resume];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    if (!self.navigationController.navigationBarHidden) {
           [self.refreshControl setRefreshingWithStateOfTask:task];
    }
 
}
- (void) loadMoreData{
    NSString *urlPrefix = @"http://news.at.zhihu.com/api/3/news/before/";
    NSString *fullUrl = [urlPrefix stringByAppendingString:self.date];
    NSURLSessionDataTask *task = [self getDataFrom:fullUrl];
    [task resume];

}
-(NSURLSessionDataTask *) getDataFrom:(NSString *)Url{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:Url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *json = (NSDictionary *)responseObject;
            self.date = [json objectForKey:@"date"];
            // NSDictionary *storyJson =[json objectForKey:@"stories"];
            if ([json isKindOfClass:[NSDictionary class]]){
                NSArray *stories = json[@"stories"];
                if ([stories isKindOfClass:[NSArray class]]){
                    for (NSDictionary *dictionary in stories) {
                        self.story = [[Stories alloc]init];
                        self.story.id = [dictionary objectForKey:@"id"];
                        self.story.title = [dictionary objectForKey:@"title"];
                        self.story.images = [dictionary objectForKey:@"images"];
                        self.story.share_url = [dictionary objectForKey:@"share_url"];
                        self.story.ga_prefix = [dictionary objectForKey:@"ga_prefix"];
                        self.story.date = self.date;
                        self.story.type = @([[dictionary objectForKey:@"type"] integerValue]);
                        //Do this for all property
                        if(nil == self.storyArrary){
                            self.storyArrary = [[NSMutableArray alloc] init];
                        }
                        [self.storyArrary addObject:self.story];
                    }
                }
                self.allStoryArrary =[NSArray arrayWithArray:self.storyArrary];
                [self.mainTableview reloadData];
            }
        }
    }];
    
    return task;
}

- (void) tapFavorites{
    FavTableViewController *ftc = [[self storyboard]instantiateViewControllerWithIdentifier:@"FavList"];
    [self.navigationController showViewController:ftc sender:nil];
}

- (void) tapSetting{
    SettingTableViewController *stc = [[self storyboard]instantiateViewControllerWithIdentifier:@"setting"];
    [self.navigationController showViewController:stc sender:nil];
}
- (void) querySplash {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MMM-yyy"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![time isEqualToString:[userDefaults stringForKey:@"time"]]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://news-at.zhihu.com/api/3/start-image/1080*1776" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *json = (NSDictionary *)responseObject;
            [self downloadSpashWith:json];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
   
}

- (void) downloadSpashWith: (NSDictionary *)Json {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MMM-yyy"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    NSURL *URL = [NSURL URLWithString:[Json objectForKey:@"img"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    AFHTTPRequestOperation *downloadRequest = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [downloadRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [[NSData alloc] initWithData:responseObject];
        UIImage *image = [[UIImage alloc] initWithData:data];
        NSString *pngFilePath = [NSString stringWithFormat:@"%@/splash.png",documentsDirectory];
        NSData *imagedata = [NSData dataWithData:UIImagePNGRepresentation(image)];
        [imagedata writeToFile:pngFilePath atomically:YES];
        [userDefaults setValue:time forKey:@"time"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"file downloading error : %@", [error localizedDescription]);
    }];
    [downloadRequest start];
    [userDefaults setValue:[Json objectForKey:@"img"] forKey:@"img"];
    [userDefaults setValue:[Json objectForKey:@"text"] forKey:@"text"];
    [userDefaults synchronize];
  }

- (void) showSplash {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *splashPath = [documentsDirectory stringByAppendingPathComponent:@"splash.png"];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIImageView *splashView = [[UIImageView alloc] initWithFrame:screenBounds];
    UIImage *splashImage = [UIImage imageWithContentsOfFile:splashPath];
    if(splashImage){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        splashView.image = splashImage;
        [self.view addSubview:splashView];
        [self.view bringSubviewToFront:splashView];  //放到最顶层;
        [UIView transitionWithView:self.view duration:3.0f options:UIViewAnimationOptionTransitionNone animations:^(void){splashView.alpha=0.0f;}
                        completion:^(BOOL finished){
                            [splashView removeFromSuperview];
                            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
                            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }];
    }
}

-(void)refrash
{
    [self.tableView reloadData];
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"night"]){
        //night mode
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.view.backgroundColor = [self stringToColor:@"#343434"];
    }else{
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        self.navigationController.navigationBar.tintColor = nil;
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

- (UIColor *) stringToColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

- (BOOL) serachWith:(Stories *) stories{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"FavStories"inManagedObjectContext:self.managedObjectContext]];
    NSNumber *id = stories.id;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id==%@", id]];
    NSError* error = nil;
    NSArray* results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0) {
        return YES;
    }else{
        return NO;
    }
    
}
@end
