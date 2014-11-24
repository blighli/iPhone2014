//
//  ViewController.m
//  Evernote
//
//  Created by JANESTAR on 14-11-15.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//
#import "AppDelegate.h"
#import "ViewController.h"
#import "detailCameraViewController.h"
#import "Camera.h"
#import "detailCameraViewController.h"
@interface ViewController ()


@property(nonatomic,strong)NSFetchedResultsController* fetchResultController;

@end

@implementation ViewController{
    AppDelegate* appDelegate;
    NSManagedObjectContext* appContext;

}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    id  sectionInfo =
    [[self.fetchResultController sections] objectAtIndex:section];
    
    
    // NSLog(@"the numberofobj is%lu",(unsigned long)[sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
    
    // return [self.dataList count];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Camera* camera = [self.fetchResultController objectAtIndexPath:indexPath];
    NSLog(@"camera title is%@",camera.title);
    cell.textLabel.text = camera.title;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* CellWithIdentifier=@"Camera";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellWithIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailCameraViewController* cameravc=[[detailCameraViewController alloc]init];
    NSUInteger row=[indexPath row];
    cameravc.row=row;
    cameravc.flag=YES;
    cameravc.mark=YES;
    cameravc.camera=[self.fetchResultController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:cameravc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        // [self.myTableView deleteRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:<#(UITableViewRowAnimation)#>]
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Camera" inManagedObjectContext:appContext];
        [request setEntity:entity];
        [request setReturnsObjectsAsFaults:NO];
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"self =%@", [self.fetchResultController objectAtIndexPath:indexPath]];
        [request setPredicate:predicate];
        NSArray *dataArray = [appContext executeFetchRequest:request error:nil];
        // NSLog(@"count is %lu",(unsigned long)[dataArray count]);
        if ([dataArray count] > 0) {
            Camera* camera= [dataArray objectAtIndex:0];
            NSFileManager* fileManager=[NSFileManager defaultManager];
            NSString* subloc=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),camera.title];
            BOOL t=[fileManager removeItemAtPath:subloc error:nil];
            if(t){
                printf("yes delete\n");
            }
            [appContext deleteObject:camera];
            NSError* error;
            [appContext save:&error];
            if (error!=nil) {
                NSLog(@"%@",error);
            }else{
                NSLog(@"删除成功");
            }
            
            
            
        }
        
        
    }
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication]delegate];
    appContext=[appDelegate managedObjectContext];

    self.view.backgroundColor=[UIColor grayColor];
    self.navigationItem.title=@"照片笔记";
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,375,self.view.frame.size.height-44)style:(UITableViewStylePlain)];
    [self.view addSubview:tableView];
    //UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(bookMark)];
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"files.png"] style:UIBarButtonItemStyleDone target:self action:@selector(addCamera)];
   // UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(addCamera)];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem=item;
    self.myTableView=tableView;
    self.myTableView.dataSource=self;
    self.myTableView.delegate=self;
    [self.view addSubview:self.myTableView];
    //[self.view addSubview:tableView];
    NSFetchedResultsController* resultController=[self getAllText];
    //resultController.delegate=self;
    self.fetchResultController=resultController;
    self.fetchResultController.delegate=self;
    NSError *error;
    if (![self.fetchResultController performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }

    
    
}
-(void)addCamera{
  
    detailCameraViewController * de=[[detailCameraViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSFetchedResultsController*)getAllText{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //Entity
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Camera" inManagedObjectContext:appContext];
    [request setEntity:entityDescription];
    
    //Sort
    //NSFetchedResultController必须有Sort
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSFetchedResultsController* controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:appContext sectionNameKeyPath:nil cacheName:nil];
    
    //Must perform fetch once.
    NSError *error = nil;
    [controller performFetch:&error];
    
    return controller;
    
    
}
#pragma mark NSFetchedResultsControllerDelegate
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"controllerWillChangeContent");
    [self.myTableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    NSLog(@"didChangeSection");
    
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.myTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:break;
    }
    
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    NSLog(@"didChangeObject");
    
    UITableView *tableView = self.myTableView;
    
    switch(type) {
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
    [self.myTableView endUpdates];
}



@end
