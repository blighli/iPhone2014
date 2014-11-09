//
//  ToDoListTableCtl.m
//  todolist
//
//  Created by zhou on 14/11/6.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "ToDoListTableCtl.h"
#import "Item.h"
#import "AddToDoItemCtl.h"
#import "AppDelegate.h"
#import "CoreDataMethod.h"

@interface ToDoListTableCtl ()

@end

@implementation ToDoListTableCtl

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.toDoItems = [[NSMutableArray alloc] init];

    self.Items = [[NSMutableArray alloc] init];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];

    [self loadInitalData];
}

- (void)loadInitalData
{
    self.Items = [CoreDataMethod fetchAllInContext:self.managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    return [self.Items count];
}

- (IBAction)clearItemDone:(id)sender
{
    for (Item *item in self.Items)
    {
        if (item.isCompleted.boolValue)
        {
            [CoreDataMethod deleteItem:item inContext:self.managedObjectContext];
        }
    }
    [self.Items removeAllObjects];
    self.Items = self.Items = [CoreDataMethod fetchAllInContext:self.managedObjectContext];
    [self.tableView reloadData];
}

- (IBAction)unWindToList:(UIStoryboardSegue *)segue
{
    AddToDoItemCtl *source = [segue sourceViewController];

    if (source.todoItem != nil)
    {
        [self.Items addObject:source.todoItem];
        [self.tableView reloadData];
        [CoreDataMethod addItem:source.todoItem inContext:self.managedObjectContext];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];

    Item *todoItem = [self.Items objectAtIndex:indexPath.row];
    cell.textLabel.text = todoItem.itemName;
    if ([todoItem.isCompleted boolValue])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Item *selectedItem = [self.Items objectAtIndex:indexPath.row];

    selectedItem.isCompleted = selectedItem.isCompleted.boolValue == YES ? @NO : @YES;
    [CoreDataMethod updateItem:selectedItem inContext:self.managedObjectContext];

    [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source

        if (indexPath.row < [self.Items count])
        {
            Item *todoitem = [self.Items objectAtIndex:indexPath.row];

            if (![CoreDataMethod deleteItem:todoitem inContext:self.managedObjectContext])
            {
                NSLog(@"Error delete!");
            }
            else
            {
                [self.Items removeObjectAtIndex:indexPath.row];

                [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
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

@end
