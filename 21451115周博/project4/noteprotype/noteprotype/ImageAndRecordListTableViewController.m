//
//  ImageAndRecordListTableViewController.m
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "ImageAndRecordListTableViewController.h"
#import "ApplicationConstants.h"
#import "PhotoHelper.h"
#import "PaintHelper.h"
#import "RecordHelper.h"
#import "AppDelegate.h"
#import "PaintViewController.h"
#import "PhotoViewController.h"


@interface ImageAndRecordListTableViewController ()
@property NSMutableArray *photoList;
@property NSMutableArray *audioList;
@property NSMutableArray *paintList;
@end

@implementation ImageAndRecordListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.photoList = [[NSMutableArray alloc] initWithArray:[self.note.photoContainer allObjects]];
    self.audioList = [[NSMutableArray alloc] initWithArray:[self.note.recordContainer allObjects]];
    self.paintList = [[NSMutableArray alloc] initWithArray:[self.note.paintContainer allObjects]];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(reloadList:)
               name:NSManagedObjectContextObjectsDidChangeNotification
             object:context];
}

// only reload the table data, leave the context saved by another observer
- (void)reloadList:(NSNotification *)notification
{
   // NSLog(@"reload AudioList?");
    self.photoList = [[NSMutableArray alloc] initWithArray:[self.note.photoContainer allObjects]];
    self.audioList = [[NSMutableArray alloc] initWithArray:[self.note.recordContainer allObjects]];
    self.paintList = [[NSMutableArray alloc] initWithArray:[self.note.paintContainer allObjects]];

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

    NSInteger count = self.audioList.count + self.paintList.count + self.photoList.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kImageAndRecordListCell forIndexPath:indexPath];

    //photo entity
    if (indexPath.row < self.photoList.count)
    {
        Photo *photo = [self.photoList objectAtIndex:indexPath.row];
        cell.textLabel.text = photo.photoName;
        //cell.imageView.image = [photo getImage];
        cell.imageView.image = [photo getImage];
    }
    //audio entity
    else if (indexPath.row > self.photoList.count && indexPath.row < self.photoList.count + self.audioList.count)
    {
        //Record *audio = [self.audioList objectAtIndex:indexPath.row - self.photoList.count];
        //cell.textLabel.text = audio.recordName;
        //cell.imageView.image = [UIImage imageNamed:@"micro-50"];
    }
    //paint entity
    else
    {
        Paint *paint = [self.paintList objectAtIndex:indexPath.row - self.photoList.count - self.audioList.count];
        cell.textLabel.text = paint.paintName;
        cell.imageView.image = [paint getImage];
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row < self.audioList.count + self.paintList.count + self.photoList.count)
    {
        //photo entity
        if (indexPath.row < self.photoList.count)
        {
            Photo *photo = [self.photoList objectAtIndex:indexPath.row];
            
            [self performSegueWithIdentifier:kDetailToPhotoSegue sender:photo];
        }
        //audio entity
        else if (indexPath.row > self.photoList.count && indexPath.row < self.photoList.count + self.audioList.count)
        {
           // NSUInteger index = indexPath.row - self.photoList.count;
           // Record *audio = [self.audioList objectAtIndex:index];
           
        }
        //paint entity
        else
        {
            NSUInteger index = indexPath.row - self.photoList.count - self.audioList.count;
            Paint *paint = [self.paintList objectAtIndex:index];
            [self performSegueWithIdentifier:kDetailToPaintSegue sender:paint];
        }
       
    }

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

        if (indexPath.row < self.audioList.count + self.paintList.count + self.photoList.count)
        {
            //photo entity
            if (indexPath.row < self.photoList.count)
            {
                Photo *photo = [self.photoList objectAtIndex:indexPath.row];

                [self.note removePhotoContainerObject:photo];
                [self.photoList removeObjectAtIndex:indexPath.row];
            }
            //audio entity
            else if (indexPath.row > self.photoList.count && indexPath.row < self.photoList.count + self.audioList.count)
            {
                NSUInteger index = indexPath.row - self.photoList.count;
                Record *audio = [self.audioList objectAtIndex:index];
                [self.note removeRecordContainerObject:audio];
                [self.audioList removeObjectAtIndex:index];
            }
            //paint entity
            else
            {
                NSUInteger index = indexPath.row - self.photoList.count - self.audioList.count;
                Paint *paint = [self.paintList objectAtIndex:index];
                [self.note removePaintContainerObject:paint];
                [self.paintList removeObjectAtIndex:index];
            }
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //selete paint
    if ([[segue identifier]isEqualToString:kDetailToPaintSegue]) {
        PaintViewController *des = [segue destinationViewController];
        des.note = self.note;
        des.paint = (Paint*)sender;
        des.isUpdate = YES;
    }
    //select photo
    else if ([[segue identifier]isEqualToString:kDetailToPhotoSegue])
    {
        PhotoViewController *des = [segue destinationViewController];
        des.note = self.note;
        des.photo = (Photo*)sender;
        des.isUpdate = YES;
    }
    
}

@end
