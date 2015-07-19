//
//  EditNoteViewController.m
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "EditNoteViewController.h"

#import "AppDelegate.h"
#import "MyNote.h"
#import "ImageData.h"

@interface EditNoteViewController ()
@property(nonatomic,strong)NSFetchedResultsController* fetchResultController;
@end

@implementation EditNoteViewController
@synthesize delegate;
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
    appDelegate =[[UIApplication sharedApplication]delegate];
    appContext =[appDelegate managedObjectContext];
	self.navigationItem.title = @"Detail";
    UIBarButtonItem *doneitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneNote)];
    self.navigationItem.rightBarButtonItem = doneitem;
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 30)];
    titleLable.textAlignment =NSTextAlignmentCenter;
    titleLable.text = @"标题";
    _noteTitle.frame = CGRectMake(70,10, 220, 30);
    _noteTitle.delegate = self;
    UIView *content = [[UIView alloc]initWithFrame:CGRectMake(20, 50, 280, 340)];
    content.backgroundColor =[UIColor grayColor];
    // add textview and tableview
    _noteContent.frame = CGRectMake(5, 5, 270,250);
    
    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 260, 280, content.frame.size.height - 260) style:UITableViewStylePlain];
    _myTable.delegate =self;
    _myTable.dataSource =self;
   
    [content addSubview:_noteContent];
    [content addSubview:_myTable];
    
    [self.view addSubview:titleLable];
    [self.view addSubview:_noteTitle];
    [self.view addSubview:content];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)doneNote
{

    if(![_noteContent.text isEqualToString:@""] && ![_noteTitle.text isEqualToString:@""])
    {
        [self.delegate passAllValue:_noteTitle.text WithContent:_noteContent.text];

        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"MyNote" inManagedObjectContext:appContext];
        [request setEntity:entity];
        [request setReturnsObjectsAsFaults:NO];
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"note_date = %@",_noteDate];
        [request setPredicate:predicate];
        NSArray *dataArray = [appContext executeFetchRequest:request error:nil];
        
        MyNote *editNote = [dataArray objectAtIndex:0];
        [editNote setNote_title:_noteTitle.text];
        [editNote setNote_Text:_noteContent.text];

        NSError* error;
        [appContext save:&error];
        if (error!=nil) {
            NSLog(@"%@",error);
        }
        else
            NSLog(@"Yes");

        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_imageArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"imageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        image.tag = 101;
        [cell.contentView addSubview:image];
        
    }
    
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:101];
    
    ImageData *oneImg =  (ImageData*)[_imageArray objectAtIndex:indexPath.row];
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/"];
    NSString *allPath = [path stringByAppendingString:oneImg.image_path];
    
    UIImage *titleImage = [UIImage imageWithContentsOfFile:allPath];
    image.image = titleImage;
    return cell;
}
//cellHeigt
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        NSLog(@"Delete Begin");
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ImageData" inManagedObjectContext:appContext];
        [request setEntity:entity];
        [request setReturnsObjectsAsFaults:NO];
        NSLog(@"%@",[self.fetchResultController objectAtIndexPath:indexPath]);
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"self =%@", [self.fetchResultController objectAtIndexPath:indexPath]];
        [request setPredicate:predicate];
        NSArray *dataArray = [appContext executeFetchRequest:request error:nil];
        
        NSLog(@"count = %d",[dataArray count]);
        if ([dataArray count] > 0)
        {
            ImageData *deleteImg =(ImageData*) [dataArray objectAtIndex:0];
            NSFileManager* fileManager=[NSFileManager defaultManager];
            NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/"];
            NSString *allPath = [path stringByAppendingString:deleteImg.image_path];
            BOOL t=[fileManager removeItemAtPath:allPath error:nil];
            if(t)
            {
                NSLog(@"delete_path OK");
            }
            else
                NSLog(@"fail");
                
            [appContext deleteObject:deleteImg];
            NSError* error;
            [appContext save:&error];
            if (error!=nil)
            {
                NSLog(@"%@",error);
            }else
            {
                NSLog(@"删除成功");
            }
            NSLog(@"Delete Begin");
            
            
        }
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
