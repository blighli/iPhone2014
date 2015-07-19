//
//  ViewController.m
//  MyNotes
//
//  Created by 杨长湖 on 14/11/23.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)addNoteButten:(id)sender;

@end

@implementation ViewController
   // NSMutableArray *noteList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NoteDAO *dao = [[NoteDAO alloc]init];
    self.noteList = [dao SelectNoteData];
}
//刷新
-(void)viewWillAppear:(BOOL)animated{
    NoteDAO *dao = [[NoteDAO alloc]init];
    self.noteList = [dao SelectNoteData];
    [self.tv reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.noteList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"noteListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Note  *note = [self.noteList objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.editingAccessoryType=UITableViewCellEditingStyleDelete;
    cell.showsReorderControl = YES;
    cell.textLabel.text=[note note];
    cell.detailTextLabel.text = [note time];
  
    return cell;
}

//增加笔记
- (IBAction)addNoteButten:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *addNoteViewContent = [mainStoryboard instantiateViewControllerWithIdentifier:@"addNoteViewContenter"];
    addNoteViewContent.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:addNoteViewContent animated:YES completion:^{NSLog(@"Go To AddNoteView");}];
}
//编辑
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
        editNoteViewController *destViewController = segue.destinationViewController;
        //RecipeDetailViewController *destViewController = segue.destinationViewController;
        destViewController.editNote = [self.noteList objectAtIndex:indexPath.row];
    }
}

//删除笔记
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"shanchu");
    Note *deleteNote = [self.noteList objectAtIndex:indexPath.row];
    NSLog(@"detele--%d",deleteNote.ids);
    NoteDAO *dao = [[NoteDAO alloc]init];
    [dao deleteNoteWithId:deleteNote.ids];
    self.noteList = [dao SelectNoteData];
    [self.tv reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
