//
//  NoteDetailViewController.m
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "EditNoteViewController.h"
#import "ImageData.h"
@interface NoteDetailViewController ()

@end

@implementation NoteDetailViewController

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
    self.navigationItem.title = @"Detail";
    UIBarButtonItem *additem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editNote)];
    self.navigationItem.rightBarButtonItem = additem;
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 30)];
    titleLable.textAlignment =NSTextAlignmentCenter;
    titleLable.text = @"标题";
    _noteTitle.frame = CGRectMake(70,10, 220, 30);
    
    UIView *content = [[UIView alloc]initWithFrame:CGRectMake(20, 50, 280, 340)];
    content.backgroundColor =[UIColor grayColor];
    // add textview and tableview
    _notetext.frame = CGRectMake(5, 5, 270,250);
    _notetext.delegate = self;

    UITableView* imageTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 260, 280, content.frame.size.height - 260) style:UITableViewStylePlain];
    imageTable.delegate =self;
    imageTable.dataSource =self;
    [content addSubview:_notetext];
    [content addSubview:imageTable];
    
    [self.view addSubview:titleLable];
    [self.view addSubview:_noteTitle];
    [self.view addSubview:content];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView isFirstResponder]){
        return YES;
    }
    return NO;
}

-(void)editNote
{
    EditNoteViewController *EnVC = [[EditNoteViewController alloc]init];
    //NoteDetailViewController *NDVc = [[NoteDetailViewController alloc]init];
    EnVC.delegate =self;
    EnVC.noteTitle = [[UITextField alloc]init];
    EnVC.noteTitle.text = _noteTitle.text;
    EnVC.noteContent = [[UITextView alloc]init];
    EnVC.noteContent.text = _notetext.text;
    EnVC.noteDate = _noteDate;
    if([_imageArray count] != 0)
    {
        EnVC.imageArray = [[NSArray alloc]initWithArray:_imageArray];
    }
    
    [self.navigationController pushViewController:EnVC animated:YES];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"@image count = %@",[_imageArray count]);
    return [_imageArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"imageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //NSLog(@"@image count = %d",[_imageArray count]);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)passAllValue:(NSString *)title WithContent:(NSString *)content;
{
    _noteTitle.text = title;
    _notetext.text = content;
    [_notetext reloadInputViews];
    [_noteTitle reloadInputViews];
}


@end
