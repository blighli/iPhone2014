//
//  PicViewController.m
//  Evernote
//
//  Created by JANESTAR on 14-11-15.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import "AppDelegate.h"
#import "PicViewController.h"
#import "PaintViewController.h"
#import "Picture.h"
#import "Paint.h"

@interface PicViewController ()
@property(nonatomic,strong)NSFetchedResultsController* fetchResultController;
@end

@implementation PicViewController{

    AppDelegate* appDelegate;
    NSManagedObjectContext* appContext;
    Paint* paint;

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
    Picture* pic = [self.fetchResultController objectAtIndexPath:indexPath];
    cell.textLabel.text = pic.subloc;
    

}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* CellWithIdentifier=@"Pic";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellWithIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaintViewController* paintvc=[[PaintViewController alloc]init];
    NSUInteger row=[indexPath row];
    paintvc.row=row;
    paintvc.flag=YES;
    paintvc.mark=YES;
    paintvc.pic=[self.fetchResultController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:paintvc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        // [self.myTableView deleteRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:<#(UITableViewRowAnimation)#>]
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Picture" inManagedObjectContext:appContext];
        [request setEntity:entity];
        [request setReturnsObjectsAsFaults:NO];
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"self =%@", [self.fetchResultController objectAtIndexPath:indexPath]];
        [request setPredicate:predicate];
        NSArray *dataArray = [appContext executeFetchRequest:request error:nil];
        // NSLog(@"count is %lu",(unsigned long)[dataArray count]);
        if ([dataArray count] > 0) {
            Picture* pic= [dataArray objectAtIndex:0];
            NSFileManager* fileManager=[NSFileManager defaultManager];
            NSString* subloc=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),pic.subloc];
            BOOL t=[fileManager removeItemAtPath:subloc error:nil];
            if(t){
                printf("yes delete\n");
            }
            [appContext deleteObject:pic];
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
    self.navigationItem.title=@"图片笔记";
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,375,self.view.frame.size.height-44)style:(UITableViewStylePlain)];
    self.myTableView=tableView;
    self.myTableView.dataSource=self;
    self.myTableView.delegate=self;
    [self.view addSubview:self.myTableView];
    //[self.view addSubview:tableView];
    //UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(bookMark)];
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"files.png"] style:UIBarButtonItemStyleDone target:self action:@selector(picDetail)];
   // UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(picDetail)];
    // Do any additional setup after loading the view, typically from a nib.
   self.navigationItem.rightBarButtonItem=item;
    
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

    // Do any additional setup after loading the view.
}

-(void)picDetail{
    PaintViewController* paintvc=[[PaintViewController alloc]init];
    [self.navigationController pushViewController:paintvc animated:YES];
    
}

-(NSFetchedResultsController*)getAllText{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //Entity
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Picture" inManagedObjectContext:appContext];
    [request setEntity:entityDescription];
    
    //Sort
    //NSFetchedResultController必须有Sort
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"loc" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSFetchedResultsController* controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:appContext sectionNameKeyPath:nil cacheName:nil];
    
    //Must perform fetch once.
    NSError *error = nil;
    [controller performFetch:&error];
    
    return controller;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
