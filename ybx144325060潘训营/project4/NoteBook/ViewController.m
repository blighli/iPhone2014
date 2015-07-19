//
//  ViewController.m
//  NoteBook
//
//  Created by Mz on 14-11-23.
//  Copyright (c) 2014年 pxy. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"
#import "TextViewController.h"
#import "ImageViewController.h"
@interface ViewController ()
@property (nonatomic) Note* currentNote;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.noteData = [[NSMutableArray alloc] initWithArray:[Note MR_findAllSortedBy:@"date" ascending:NO]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButton:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    NSString *toEdit = @"编辑", *cancelEdit = @"取消编辑";
    if ([button.title isEqualToString:toEdit]) {
        [button setTitle:cancelEdit];
        [self.tableView setEditing:YES animated:YES];
    } else {
        [button setTitle:toEdit];
        [self.tableView setEditing:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.noteData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    Note* note = [self.noteData objectAtIndex:indexPath.row];
    switch ([note.type intValue]) {
        case NoteTypeText:
            cell.textLabel.text = note.content;
            break;
        case NoteTypePhoto:
            cell.textLabel.text = @"[照片]";
            break;
        case NoteTypeDarwing:
            cell.textLabel.text = @"[涂鸦]";
            break;
        default:
            cell.textLabel.text = @"[错误]";
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[self.noteData objectAtIndex:indexPath.row] MR_deleteEntity];
        [self.noteData removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentNote = [self.noteData objectAtIndex:indexPath.row];
    switch ([self.currentNote.type intValue]) {
        case NoteTypeText:
            [self performSegueWithIdentifier:@"text" sender:self];
            break;
        case NoteTypePhoto:
        case NoteTypeDarwing:
            [self performSegueWithIdentifier:@"image" sender:self];
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
    
    if([segue.identifier isEqualToString:@"text"]) {
        TextViewController *textNote = (TextViewController*) dest;
        textNote.currentNote = self.currentNote;
    } else if([segue.identifier isEqualToString:@"image"]) {
        ImageViewController *imageView = (ImageViewController*) dest;
        NSString *path = self.currentNote.content;
        imageView.image = [UIImage imageWithContentsOfFile:self.currentNote.content];
    }
}
@end
