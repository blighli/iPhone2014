//
//  TableViewController.m
//  todolist
//
//  Created by Van on 14/11/6.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "TableViewController.h"
#import "AddToDoItemViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    //[self.tableView reloadData];
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
    return [[TableViewController getResult:self.managedObjectContext] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    NSArray *array = [NSMutableArray arrayWithArray:[TableViewController getResult:self.managedObjectContext]];
    TodoItem *item = [array objectAtIndex:indexPath.row];
    NSLog(@"展示的数据 %@",item.id);
    cell.textLabel.text = item.item;
    // Configure the cell...
    
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
        NSArray *array = [NSMutableArray arrayWithArray:[TableViewController getResult:self.managedObjectContext]];
        TodoItem *item = [array objectAtIndex:indexPath.row];
        [TableViewController deleteCell:item :self.managedObjectContext];
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


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [NSMutableArray arrayWithArray:[TableViewController getResult:self.managedObjectContext]];
    TodoItem *item = [array objectAtIndex:indexPath.row];
    NSLog(@"cell item %@",item.id);
    AddToDoItemViewController *Controller = [[self storyboard]instantiateViewControllerWithIdentifier:@"additem"];
    Controller.item = item;
    [[self navigationController] pushViewController:Controller animated:YES];
    
}
- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
}

+ (NSMutableArray *) getResult:(NSManagedObjectContext *)managedObjectContext
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TodoItem"inManagedObjectContext:managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    return mutableFetchResult;
}

+(void) deleteCell:(TodoItem *)item :(NSManagedObjectContext *)managedObjectContext{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"TodoItem"inManagedObjectContext:managedObjectContext]];
    
    //删除谁的条件在这里配置；
    NSString *id = item.id;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id==%@", id]];
    NSError* error = nil;
    NSArray* results = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0) {
        [managedObjectContext deleteObject:[results objectAtIndex:0]];
        NSLog(@"删除的数据 %@",[results objectAtIndex:0]);

    }
    [managedObjectContext save:&error];
}
-(void)refrash
{
    [self.tableView reloadData];
}
@end
