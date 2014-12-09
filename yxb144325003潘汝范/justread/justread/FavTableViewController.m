//
//  FavTableViewController.m
//  justread
//
//  Created by Van on 14/12/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "FavTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "FavStories.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "Utils.h"
@interface FavTableViewController ()
@property NSManagedObjectContext *managedObjectContext;
@property Utils *util;
@end

@implementation FavTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.util = [[Utils alloc] init];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(refrashFav)
                                                name:@"refrashFav"//消息名
                                              object:nil];
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    [self setSKin];

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
    return [[self.util getResult:self.managedObjectContext] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavStories *story = [[self.util getResult:self.managedObjectContext] objectAtIndex:indexPath.row];//= [self.allStoryArrary objectAtIndex:indexPath.row];
    //  [self.mainTableview registerClass: [ZhiTableViewCell class] forCellReuseIdentifier:@"zhihucell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favcell" forIndexPath:indexPath];
    [cell.textLabel setText:story.title];
    [cell.textLabel setNumberOfLines:2];
    NSURL *url = [NSURL URLWithString: story.images];
    if (![story.images isEqualToString:@""]) {
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"night"]){
        //night mode
        cell.backgroundColor = [self.util stringToColor:@"#343434"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FavStories *story = [[self.util getResult:self.managedObjectContext] objectAtIndex:indexPath.row];
    DetailViewController *Controller = [[self storyboard]instantiateViewControllerWithIdentifier:@"detail"];
    Stories *tmp =[[Stories alloc] init];
    tmp.id = story.id;
    tmp.title = story.title;
    tmp.share_url = story.share_url;
    tmp.ga_prefix = story.ga_prefix;
    tmp.date = story.date;
    tmp.type = story.type;
    tmp.images = [[NSArray alloc] initWithObjects:story.images, nil];
    Controller.story = tmp;
    Controller.isFaved = YES;
    [self.navigationController showViewController:Controller sender:nil];
    
}
-(void)refrashFav
{
    [self.favtableView reloadData];
    [self setSKin];
}

- (void) setSKin{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"night"]){
        //night mode
        self.navigationController.navigationBar.barStyle =UIBarStyleBlack;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.view.backgroundColor = [self.util stringToColor:@"#343434"];
    }else{
        self.navigationController.navigationBar.barStyle =UIBarStyleDefault;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        self.navigationController.navigationBar.tintColor =[self.navigationController.navigationBar tintColor];
        self.view.backgroundColor = [UIColor whiteColor];
    }
}
@end
