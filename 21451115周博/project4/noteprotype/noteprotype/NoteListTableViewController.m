//
//  NoteListTableViewController.m
//  noteprotype
//
//  Created by zhou on 14/11/21.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "NoteListTableViewController.h"
#import "ApplicationConstants.h"
#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "PhotoHelper.h"
#import "PaintHelper.h"

#import "DetailViewController.h"

@interface NoteListTableViewController ()

@property NSMutableArray *NoteList;
@property (nonatomic, strong) NSManagedObjectContext *context;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNoteBtn;

@end

@implementation NoteListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = [appDelegate managedObjectContext];

    self.NoteList = [[NSMutableArray alloc] init];
    self.NoteList = [CoreDataHelper getAllNote:self.context];

    // regist the observer when context changed(update,delete,insert)

    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(reloadList:)
               name:NSManagedObjectContextObjectsDidChangeNotification
             object:self.context];
}

// only reload the table data, leave the context saved by another observer
- (void)reloadList:(NSNotification *)notification
{
    //NSLog(@"reload NoteList?");//;
    self.NoteList = [CoreDataHelper getAllNote:self.context];
    [self.tableView reloadData];
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
    return [self.NoteList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyNoteListCell forIndexPath:indexPath];

    Note *note = [self.NoteList objectAtIndex:indexPath.row];

    cell.textLabel.text = note.title;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    cell.detailTextLabel.text = [formatter stringFromDate:note.lastModifyTime];

    //choose a random photo or paint to show at table list
    Photo *photo = [note.photoContainer anyObject];
    Paint *paint = [note.paintContainer anyObject];

    if (photo != nil)
    {
        cell.imageView.image = [photo getImage];
    }
    else
    {
        cell.imageView.image = [paint getImage];
    }

    return cell;
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

        if (indexPath.row < [self.NoteList count])
        {
            Note *note = [self.NoteList objectAtIndex:indexPath.row];

            [CoreDataHelper deleteNote:note inContext:self.context];

            [self.NoteList removeObjectAtIndex:indexPath.row];

            [tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Navigation

//the segue for unwind
//Nothing to do here ,because coredata store the data automatically once the context changed
//so, no need to do the saveing date action

- (IBAction)unWindFromDetailToNoteList:(UIStoryboardSegue *)segue
{
    DetailViewController *source = [segue sourceViewController];

    if (source.note != nil)
    {
        // NSLog(@"%@",source.note.content);
        // Note* note = source.note;

        // [self.NoteList addObject:source.note];
        // [self.tableView reloadData];
        // [CoreDataMethod addItem:source.todoItem inContext:self.managedObjectContext];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    // create a new note
    if (sender == self.addNoteBtn)
    {
        DetailViewController *destination = segue.destinationViewController;
        destination.note = (Note *)[CoreDataHelper CreateEntityFactory:kNote inContext:self.context];
    }

    
    
    // show the detail of the selected note
    if ([[segue identifier] isEqualToString:kNoteListToDetailSegue])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Note *note = [self.NoteList objectAtIndex:indexPath.row];
        DetailViewController *noteDetailViewController = segue.destinationViewController;

        noteDetailViewController.note = note;
    }
}

@end
