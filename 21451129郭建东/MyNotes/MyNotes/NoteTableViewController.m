//
//  NoteTableViewController.m
//  MyNotes
//
//  Created by cstlab on 14/11/11.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "NoteTableViewController.h"
#import "AddViewController.h"
#import "NoteDetailViewController.h"

@interface NoteTableViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>

@property NSMutableArray *filteredNoteArray;
@property  UISearchBar *bar;
@property UISearchDisplayController *searchDispCtrl;

@end

@implementation NoteTableViewController
@synthesize  noteArray,dateArray,filteredNoteArray,bar,searchDispCtrl;

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self)
    {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.noteArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"note"];
    self.dateArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"date"];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addbtn = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    self.navigationItem.rightBarButtonItem = addbtn;
    self.navigationItem.title =@"MyNote";
    
    bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 44)];
    searchDispCtrl = [[UISearchDisplayController  alloc]initWithSearchBar:bar contentsController:self];
    
    searchDispCtrl.delegate = self;
    searchDispCtrl.searchResultsDataSource = self;
    searchDispCtrl.searchResultsDelegate = self;
    self.tableView.tableHeaderView = bar;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)addNote
{
    AddViewController *detailViewCtrl = [[AddViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [filteredNoteArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchString];
    NSArray *tempArray = [noteArray filteredArrayUsingPredicate:predicate];
    filteredNoteArray = [NSMutableArray arrayWithArray:tempArray];
    return  YES;
}
/*
#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteDetailViewController *modify  = [[NoteDetailViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:modify animated:YES];
    NSInteger row = [indexPath row];
    modify.index = row;
    
}

 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteDetailViewController *modifyCtrl = [[NoteDetailViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:modifyCtrl animated:YES];
    NSInteger row = [indexPath row];
    modifyCtrl.index = row;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredNoteArray count];
    }
    else return [noteArray count];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [noteArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    NSString *note = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        note = [filteredNoteArray objectAtIndex:indexPath.row];
    }else if(tableView == self.tableView)
    {
        note = [noteArray objectAtIndex:indexPath.row];
    }
    
    NSString *date = [dateArray objectAtIndex:indexPath.row];
    NSUInteger charnum = [note length];
    if(charnum <22)
    {
        cell.textLabel.text = note;
    }else{
       cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"...."];
       //cell.textLabel.text = note;
    }
    
    NSLog(@"%@",date);
    cell.detailTextLabel.text = date;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    return  cell;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
