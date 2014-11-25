//
//  ViewController.m
//  MyNotes
//
//  Created by alwaysking on 14/11/18.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "TextNote.h"
#import "PictureNote.h"
#import "DrawingNote.h"
#import "TextNoteViewController.h"
#import "PicNoteViewController.h"
#import "DrawNoteViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize managedObjectContext;
@synthesize textFetchRequest;
@synthesize picFetchRequest;
@synthesize drawFetchRequest;
@synthesize tableViewInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    textFetchRequest = [[NSFetchRequest alloc] init];
    picFetchRequest = [[NSFetchRequest alloc] init];
    drawFetchRequest = [[NSFetchRequest alloc] init];
    textNoteArray = [[NSMutableArray alloc]init];
    picNoteArray = [[NSMutableArray alloc]init];
    drawNoteArray = [[NSMutableArray alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TextNote"
                                              inManagedObjectContext:self.managedObjectContext];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"PictureNote"
                                              inManagedObjectContext:self.managedObjectContext];
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"DrawingNote"
                                              inManagedObjectContext:self.managedObjectContext];
    NSError *error;

    [textFetchRequest setEntity:entity];
    [picFetchRequest setEntity:entity1];
    [drawFetchRequest setEntity:entity2];
    textNoteArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:textFetchRequest error:&error]];
    picNoteArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:picFetchRequest error:&error]];
    drawNoteArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:drawFetchRequest error:&error]];
    selectNote = 0;
    tableItemClick = false;
}

-(void)viewWillAppear:(BOOL)animated
{
    [tableViewInfo reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//删除记录
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld",(long)indexPath.row)  ;
        PictureNote *picNote;
        DrawingNote *drawNote;
        NSString *fileDirectory = [self documentsPathForFileName:nil];
        NSString *filePath;
        switch (selectNote) {
            case 0:
                [self.managedObjectContext deleteObject:[textNoteArray objectAtIndex:[textNoteArray count] - [indexPath row] - 1]];
                [textNoteArray removeObjectAtIndex:[textNoteArray count] - [indexPath row] - 1];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationTop];
                break;
            case 1:
                [self.managedObjectContext deleteObject:[picNoteArray objectAtIndex:[picNoteArray count] - [indexPath row] - 1]];
                picNote = [picNoteArray objectAtIndex:[picNoteArray count] - indexPath.row - 1];
                [picNoteArray removeObjectAtIndex:[picNoteArray count] - [indexPath row] - 1];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationTop];
            
                filePath = [fileDirectory stringByAppendingPathComponent:picNote.picRoot];
                if ([fileManager removeItemAtPath:filePath error:nil]) {
                    NSLog(@"delete success!!!");
                }
                break;
            case 2:
                [self.managedObjectContext deleteObject:[drawNoteArray objectAtIndex:[drawNoteArray count] - [indexPath row] - 1]];
                drawNote = [drawNoteArray objectAtIndex:[drawNoteArray count] - indexPath.row - 1];
                [drawNoteArray removeObjectAtIndex:[drawNoteArray count] - [indexPath row] - 1];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationTop];
                
                
                filePath = [fileDirectory stringByAppendingPathComponent:drawNote.drawingRoot];
                if ([fileManager removeItemAtPath:filePath error:nil]) {
                    NSLog(@"delete success!!!");
                }
                break;
        }
        [self.managedObjectContext save:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableDataRow = indexPath.row;
    tableItemClick = true;
    UIViewController *next;
    switch (selectNote) {
        case 0:
            next = [[self storyboard] instantiateViewControllerWithIdentifier:@"textNoteDetail"];
            break;
        case 1:
            next = [[self storyboard] instantiateViewControllerWithIdentifier:@"picNoteDetail"];
            break;
        case 2:
            next = [[self storyboard] instantiateViewControllerWithIdentifier:@"drawNoteDetail"];
            break;
    }
    [self presentViewController:next animated:YES completion:nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (selectNote) {
        case 0:
            return [textNoteArray count];
            break;
        case 1:
            return [picNoteArray count];
            break;
        case 2:
            return [drawNoteArray count];
            break;
    }
    return [textNoteArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    TextNote *note;
    PictureNote *picNote;
    DrawingNote *drawNote;
    switch (selectNote) {
        case 0:
            note = [textNoteArray objectAtIndex:[textNoteArray count] - indexPath.row - 1];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",note.textItem];
            break;
        case 1:
            picNote = [picNoteArray objectAtIndex:[picNoteArray count] - indexPath.row - 1];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",picNote.name];
            break;
        case 2:
            drawNote = [drawNoteArray objectAtIndex:[drawNoteArray count] - indexPath.row - 1];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",drawNote.name];
            break;
    }
   
    return cell;
}


- (IBAction)btnTextNote:(id)sender{
    selectNote = 0;
    [tableViewInfo reloadData];
}

- (IBAction)btnPicNote:(id)sender{
    selectNote = 1;
    [tableViewInfo reloadData];
}

- (IBAction)btnDrawNote:(id)sender{
    selectNote = 2;
    [tableViewInfo reloadData];
}

//获得文件路径
- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *testDirectory;
    NSLog(@"documentsDirectory%@",documentsDirectory);
    if (selectNote == 1) {
        testDirectory = [documentsDirectory stringByAppendingPathComponent:@"picture"];
    }
    else{
        testDirectory = [documentsDirectory stringByAppendingPathComponent:@"drawing"];
    }
    return testDirectory;
}

@end
