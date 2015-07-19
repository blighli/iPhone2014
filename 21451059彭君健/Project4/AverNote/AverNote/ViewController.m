//
//  ViewController.m
//  AverNote
//
//  Created by Mz on 14-11-19.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"
#import "TextNoteViewController.h"
#import "ImageViewController.h"
@interface ViewController ()
@property (nonatomic) Note* currentNote;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.notes = [[NSMutableArray alloc] initWithArray:[Note MR_findAllSortedBy:@"date" ascending:NO]];
    self.noteTable.dataSource = self;
    self.noteTable.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    NSString *toEdit = @"编辑", *cancelEdit = @"取消编辑";
    if ([button.title isEqualToString:toEdit]) {
        [button setTitle:cancelEdit];
        [self.noteTable setEditing:YES animated:YES];
    } else {
        [button setTitle:toEdit];
        [self.noteTable setEditing:NO];
    }
}

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    Note* note = [self.notes objectAtIndex:indexPath.row];
    switch ([note.type intValue]) {
        case NoteTypeText:
            cell.textLabel.text = note.content;
            break;
        case NoteTypePhoto:
            cell.textLabel.text = @"[照片]";
            break;
        case NoteTypeDarwing:
            cell.textLabel.text = @"[手绘]";
            break;
        default:
            cell.textLabel.text = @"[错误]";
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// 删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[self.notes objectAtIndex:indexPath.row] MR_deleteEntity];
        [self.notes removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}

// 确认删除的字符串
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"确定删除？";
}

// 点击后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentNote = [self.notes objectAtIndex:indexPath.row];
    switch ([self.currentNote.type intValue]) {
        case NoteTypeText:
            [self performSegueWithIdentifier:@"textNote" sender:self];
            break;
        case NoteTypePhoto:
        case NoteTypeDarwing:
            [self performSegueWithIdentifier:@"viewImage" sender:self];
            break;
        default:
            break;
    }
    self.currentNote = nil;
}

#pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *dest = segue.destinationViewController;
    [dest setValue:self forKey:@"mainView"];
    
    if([segue.identifier isEqualToString:@"textNote"]) {
        TextNoteViewController *textNote = (TextNoteViewController*) dest;
        textNote.currentNote = self.currentNote;
    } else if([segue.identifier isEqualToString:@"viewImage"]) {
        ImageViewController *imageView = (ImageViewController*) dest;
        imageView.image = [UIImage imageWithContentsOfFile:self.currentNote.content];
    }
}

@end
