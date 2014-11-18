//
//  MainTableViewController.m
//  mynote
//
//  Created by Van on 14/11/18.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(refrash)
                                                name:@"saveChange"//消息名
                                              object:nil];
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
    return [[MainTableViewController getResult:self.managedObjectContext] count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"webviewcell" forIndexPath:indexPath];
    // Configure the cell...
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"webviewcell"];
    UIWebView* webView = [[UIWebView alloc] initWithFrame:
                          CGRectMake(10, 0, cell.bounds.size.width , cell.bounds.size.height)];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    webView.tag = 1001;
    webView.userInteractionEnabled = NO;
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    [cell setFrame:CGRectMake(0, 0, cell.bounds.size.width , cell.bounds.size.height*1.2)];
    [cell addSubview:webView];
    webView.delegate = self;
    NSArray *array = [NSMutableArray arrayWithArray:[MainTableViewController getResult:self.managedObjectContext]];
    Notes *note = [array objectAtIndex:indexPath.row];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *Directory = [documentsDirectory stringByAppendingPathComponent:@"notesData"];
    NSString *path = [Directory stringByAppendingPathComponent:note.fileName];
    NSLog(@"path is %@",path);
    NSString *str=[[NSString alloc] initWithContentsOfFile:path];
    NSLog(@"%@",str);
    [webView loadHTMLString:str baseURL:nil];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *array = [NSMutableArray arrayWithArray:[MainTableViewController getResult:self.managedObjectContext]];
        Notes *note = [array objectAtIndex:indexPath.row];
        [MainTableViewController deleteCell:note :self.managedObjectContext];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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
+ (NSMutableArray *) getResult:(NSManagedObjectContext *)managedObjectContext
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notes"inManagedObjectContext:managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    return mutableFetchResult;
}
+(void) deleteCell:(Notes *)note :(NSManagedObjectContext *)managedObjectContext{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Notes"inManagedObjectContext:managedObjectContext]];
    
    //删除谁的条件在这里配置；
    NSString *id = note.id;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id==%@", id]];
    NSError* error = nil;
    NSArray* results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0) {
        [managedObjectContext deleteObject:[results objectAtIndex:0]];
        NSLog(@"删除的数据 %@",[results objectAtIndex:0]);
        
    }
    [managedObjectContext save:&error];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *Directory = [documentsDirectory stringByAppendingPathComponent:@"notesData"];
    NSString *path = [Directory stringByAppendingPathComponent:note.fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:NULL];
}
-(void)refrash
{
    [self.tableView reloadData];
}

@end
