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

@interface MainTableViewController ()

@property (nonatomic) Stories *story;
@property (nonatomic) NSMutableArray *storyArrary;
@property (nonatomic) NSArray *allStoryArrary;
@property (nonatomic) NSString *date;
@property (readwrite, nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self fetchJson];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
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
    if (indexPath.row == [self.allStoryArrary count] - 1) {
        [self loadMoreData];
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
    [self.navigationController showViewController:Controller sender:nil];

}
- (void) fetchJson{
    NSURLSessionDataTask *task = [self getDataFrom:@"http://news-at.zhihu.com/api/3/news/latest"];
    [task resume];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    [self.refreshControl setRefreshingWithStateOfTask:task];
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
                        //self.story.type = [[dictionary objectForKey:@"type"] integerValue];
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
    
}

- (void) tapSetting{
    
}
- (void) querySplash{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://news-at.zhihu.com/api/3/start-image/1080*1776" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *json = (NSDictionary *)responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
