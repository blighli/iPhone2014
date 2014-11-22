//
//  ViewController.m
//  mynote
//
//  Created by Devon on 14/11/20.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import "ViewController.h"
#import "NoteDetail.h"
#import "NewNoteViewController.h"
#import "Note.h"

@interface ViewController ()

@property(nonatomic, strong) NSMutableArray *notesArray; 

@end

@implementation ViewController

- (NSMutableArray *)notesArray {
    if (!_notesArray) {
        _notesArray = [NSMutableArray array];
    }
    return _notesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _myAppDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    [self.tableView reloadData];
}

- (void)loadData {
    [self.notesArray removeAllObjects];
    [self queryData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)queryData {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* note=[NSEntityDescription entityForName:@"Note" inManagedObjectContext:_myAppDelegate.managedObjectContext];
    [request setEntity:note];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[_myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
    for (Note* note in mutableFetchResult) {
        NSLog(@"name:%@----c_text:%@",note.name,note.c_text);
        [self.notesArray addObject:[note valueForKey:@"name"]];
    }
    [_myAppDelegate.managedObjectContext save:&error];
}

- (void)deleteData:(NSString *)row {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* note=[NSEntityDescription entityForName:@"Note" inManagedObjectContext:_myAppDelegate.managedObjectContext];
    [request setEntity:note];
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",row];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[_myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
    for (Note* note in mutableFetchResult) {
        [_myAppDelegate.managedObjectContext deleteObject:note];
        [_notesArray removeObjectIdenticalTo:[note valueForKey:@"name"]];
    }
    
    if ([_myAppDelegate.managedObjectContext save:&error]) {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
    }
    [self.tableView reloadData];
}

#pragma mark TableView 方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = self.notesArray[indexPath.row];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *noteName = self.notesArray[indexPath.row];
    [self deleteData:noteName];
    [self.notesArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"noteDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSString *noteIndex = self.notesArray[indexPath.row];
        [segue.destinationViewController setNoteIndex:noteIndex];
    }
}

@end
