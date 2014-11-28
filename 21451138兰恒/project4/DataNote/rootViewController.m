//
//  rootViewController.m
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "rootViewController.h"

#import "AppDelegate.h"
#import "addNewNoteViewController.h"
#import "NoteDetailViewController.h"
#import "MyNote.h"
#import "ImageData.h"

@interface rootViewController ()
@property(nonatomic,strong)NSFetchedResultsController* fetchResultController;
@end

@implementation rootViewController
AppDelegate* appDelegate;
NSManagedObjectContext* appContext;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication]delegate];
    appContext=[appDelegate managedObjectContext];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"EverNote";
    UIBarButtonItem *additem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNote)];
    self.navigationItem.rightBarButtonItem = additem;
    
    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44) style:UITableViewStyleGrouped];

    [self.view addSubview:_myTable];
    
    _myTable.delegate = self;
    _myTable.dataSource = self;
    
    NSFetchedResultsController* resultController=[self getAllText];
    self.fetchResultController=resultController;
    self.fetchResultController.delegate=self;
    NSError *error;
    if (![self.fetchResultController performFetch:&error]) {
        // Update to handle the error appropriately.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            exit(-1);  // Fail
        }
	// Do any additional setup after loading the view.
}

- (void) addNewNote
{
    addNewNoteViewController *addVC = [[addNewNoteViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo =[[self.fetchResultController sections] objectAtIndex:section];
    NSLog(@"the numberofobj is%lu",(unsigned long)[sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
    
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    MyNote* oneNote = [self.fetchResultController objectAtIndexPath:indexPath];
    
    NSSet*imageSet =  oneNote.noteAndImage;
    NSArray *imageArray = [imageSet allObjects];
    if([imageArray count] != 0)
    {
        ImageData *FristImg =  (ImageData*)[imageArray objectAtIndex:0];
        NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/"];
        NSString *allPath = [path stringByAppendingString:FristImg.image_path];
        
        UIImage *titleImage = [UIImage imageWithContentsOfFile:allPath];

        cell.imageView.image = titleImage;
        cell.textLabel.text = oneNote.note_title;
        cell.detailTextLabel.text = oneNote.note_date;
        
    }
    else
    {
        UIImage *blankImage = [UIImage imageNamed:@"blank.jpg"];
        cell.imageView.image = blankImage;
        cell.textLabel.text = oneNote.note_title;
        cell.detailTextLabel.text =oneNote.note_date;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"note";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteDetailViewController *NDVc = [[NoteDetailViewController alloc]init];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MyNote" inManagedObjectContext:appContext];
    [request setEntity:entity];
    [request setReturnsObjectsAsFaults:NO];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"self =%@", [self.fetchResultController objectAtIndexPath:indexPath]];
    [request setPredicate:predicate];
    NSArray *dataArray = [appContext executeFetchRequest:request error:nil];
    
    MyNote *oneNote = [dataArray objectAtIndex:0];
    NSSet*imageSet =  oneNote.noteAndImage;
    NSArray *imageArray = [imageSet allObjects];
    if([imageArray count] != 0)
    {
        NDVc.imageArray = [[NSArray alloc]initWithArray:imageArray];
        
    }
    NDVc.noteTitle = [[UILabel alloc]init];
    NDVc.noteTitle.text = oneNote.note_title;
    NDVc.notetext = [[UITextView alloc]init];
    NDVc.notetext.text = oneNote.note_Text;
    NDVc.noteDate = oneNote.note_date;
    
    [self.navigationController pushViewController:NDVc animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
   return YES;
 
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"MyNote" inManagedObjectContext:appContext];
        [request setEntity:entity];
        [request setReturnsObjectsAsFaults:NO];
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"self =%@", [self.fetchResultController objectAtIndexPath:indexPath]];
        [request setPredicate:predicate];
        NSArray *dataArray = [appContext executeFetchRequest:request error:nil];
        
        if ([dataArray count] > 0)
        {
            MyNote *deleteNote = [dataArray objectAtIndex:0];
            NSSet*imageSet =  deleteNote.noteAndImage;
            NSArray *imageArray = [imageSet allObjects];
            if([imageArray count]> 0)
            {
                NSFileManager* fileManager=[NSFileManager defaultManager];
                for(int i = 0;i < [imageArray count] ;i++)
                {
                    ImageData *oneImg =  (ImageData*)[imageArray objectAtIndex:i];
                    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/"];
                    NSString *allPath = [path stringByAppendingString:oneImg.image_path];
                    BOOL t=[fileManager removeItemAtPath:allPath error:nil];
                    if(t)
                    {
                        NSLog(@"delete_path OK");
                    }
                    else
                        NSLog(@"fail");
                    
                }
                
            }
            [appContext deleteObject:deleteNote];
            NSError* error;
            [appContext save:&error];
            if (error!=nil)
            {
                NSLog(@"%@",error);
            }else
            {
                NSLog(@"删除成功");
            }
            

        }
    }
    
        
}
  



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSFetchedResultsController*)getAllText
{
    
       NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
       //Entity
       NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"MyNote" inManagedObjectContext:appContext];
      [request setEntity:entityDescription];
    
        //Sort
       NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"note_date" ascending:YES];
       [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
       NSFetchedResultsController* controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:appContext sectionNameKeyPath:nil cacheName:nil];
    
       //Must perform fetch once.
        NSError *error = nil;
        [controller performFetch:&error];
        
        return controller;
       
}


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
     NSLog(@"controllerWillChangeContent");
    [self.myTable beginUpdates];
    
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    NSLog(@"didChangeSection");
    
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.myTable insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
       case NSFetchedResultsChangeDelete:
            [self.myTable deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
           break;
        default:break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
        NSLog(@"didChangeObject");
    
        UITableView *tableView = self.myTable;
    
       switch(type)
        {
                   case NSFetchedResultsChangeInsert:
                       [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                       break;
                    case NSFetchedResultsChangeDelete:
                        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                        break;
                   case NSFetchedResultsChangeUpdate:
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                        break;
                    case NSFetchedResultsChangeMove:
                        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                       [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
                       break;
            }
    }

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
        NSLog(@"controllerDidChangeContent");
        [self.myTable endUpdates];
}



@end
