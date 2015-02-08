//
//  MainViewController.m
//  MyNote
//
//  Created by Cocoa on 14/11/20.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"


@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *noteTableView;
@property (weak, nonatomic) AppDelegate *appdelegate;
@property (strong, nonatomic) NSMutableArray *allNotes;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note"inManagedObjectContext:[self.appdelegate managedObjectContext]];
    [request setEntity:entity];
    NSError *error = nil;
    
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[self.appdelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    self.allNotes = mutableFetchResult;
}

#pragma mark - TableView
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.noteTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allNotes.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"notetableViewCell";
    
    //创建cell
    UITableViewCell *cell = [self.noteTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
    }
    
    // 配置Cell详细...
    Note *note = [self.allNotes objectAtIndex: [indexPath row]];
    cell.textLabel.text = note.type;
    NSDateFormatter *nsDateformatter = [[NSDateFormatter alloc]init];
    [nsDateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.detailTextLabel.text = [nsDateformatter stringFromDate:note.date];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note* note = [self.allNotes objectAtIndex: [indexPath row]];
        [self.appdelegate.managedObjectContext deleteObject:note];
        NSError *error;
        if (![self.appdelegate.managedObjectContext save:&error]) {
            NSLog(@"Error:%@,%@",error,[error userInfo]);
        }
        else{
            NSLog(@"删除成功！");
            [self.allNotes removeObject:note];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Note* note = [self.allNotes objectAtIndex: [indexPath row]];
    if([note.type isEqual: @"笔记"]) {
        [self performSegueWithIdentifier:@"noteDetailSegue" sender:note];
    }
    else if([note.type isEqual: @"照片"]) {
        [self performSegueWithIdentifier:@"picNoteDetailSegue" sender:note];
    }
    else if([note.type isEqual: @"手绘"]) {
        [self performSegueWithIdentifier:@"doodleNoteDetailSegue" sender:note];
    }
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"noteDetailSegue"] || [segue.identifier isEqualToString:@"picNoteDetailSegue"] || [segue.identifier isEqualToString:@"doodleNoteDetailSegue"]){
        [destination setValue:sender forKey:@"note"];
    }
    else{
        [destination setValue:self.allNotes forKeyPath:@"allNotes"];
    }
}

@end
