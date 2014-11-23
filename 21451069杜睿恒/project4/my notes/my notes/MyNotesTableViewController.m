//
//  FirstViewController.m
//  my notes
//
//  Created by shazhouyouren on 14/11/15.
//  Copyright (c) 2014年 shazhouyouren. All rights reserved.
//

#import "MyNotesTableViewController.h"
#import "NoteViewController.h"
@interface MyNotesTableViewController ()

@end

@implementation MyNotesTableViewController
@synthesize titleAndIdList;
@synthesize noteDB;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    noteDB = [[NoteDB alloc] init];
    titleAndIdList = [[NSArray alloc] init];
    [self getTitleFromDB];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(reloadTableView:)
                                          name:@"NOTIFICATION_RELOAD"
                                          object:nil];
}
-(void) reloadTableView:(NSNotification *)notification{
    [self getTitleFromDB];
    [[self tableView] reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueid = [segue identifier];
    if([segueid isEqualToString:@"newNote"]){
        NoteViewController *noteView = segue.destinationViewController;
        [noteView initNewNote];
        noteView.noteDB = self.noteDB;
        noteView.editable = true;
    }
    else{
        NoteViewController *noteView = segue.destinationViewController;
        [noteView initViewNote];
        noteView.noteDB = self.noteDB;
        int row = [self.tableView indexPathForSelectedRow].row;
        NSNumber *noteid = [titleAndIdList objectAtIndex:row][@"id"];
        NSDictionary *note = [noteDB getOneNote:[noteid intValue]];
        //使用通知方式实现
        noteView.tvText=note[@"data"];
        noteView.noteid = note[@"id"];
        [noteView setTitle:note[@"time"]];
        noteView.editable = false;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleAndIdList count];
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSNumber *noteid = [titleAndIdList objectAtIndex: [indexPath row]][@"id"];
        [noteDB deleteNote:[noteid intValue]];
        [self getTitleFromDB];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
        [tableView reloadData];
    }
    
}

-(UITableViewCell*) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteCell"];
    
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noteCell"];
    }
    NSString *item = [titleAndIdList objectAtIndex: [indexPath row]][@"title"];
    [[cell textLabel] setText:item];
    return cell;
}

-(void) getTitleFromDB
{
    titleAndIdList = [noteDB getTitles];
}
@end
