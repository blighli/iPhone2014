//
//  addNewNoteViewController.m
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.a
//

#import "addNewNoteViewController.h"

#import "AppDelegate.h"
#import "DrawPhotoViewController.h"
#import "TakePhotoViewController.h"
#import "MyNote.h"
#import "ImageData.h"
@interface addNewNoteViewController ()
{
    AppDelegate* appDelegate;
    NSManagedObjectContext* appContext;
}

@end

@implementation addNewNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if(!_ImageArray)
            _ImageArray = [NSMutableArray arrayWithCapacity:1];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //隐藏nagBar
    self.navigationController.navigationBarHidden = YES;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 30)];
    titleLable.textAlignment =NSTextAlignmentCenter;
    titleLable.text = @"标题";
    _noteTitle =[[UITextField alloc]initWithFrame:CGRectMake(70,10, 220, 30)];
    _noteTitle.delegate = self;
    
    UIView *content = [[UIView alloc]initWithFrame:CGRectMake(20, 50, 280, 340)];
    content.backgroundColor =[UIColor grayColor];
    _noteTitle.borderStyle = UITextBorderStyleLine;
    // add textview and tableview
   _notetext = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, 270,250)];
    _imageTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 260, 280, content.frame.size.height - 260) style:UITableViewStylePlain];
    
    _imageTable.delegate= self;
    _imageTable.dataSource =self;
    [content addSubview:_notetext];
    [content addSubview:_imageTable];
    
    
    UIButton *takePhoto =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //takePhoto.backgroundColor = [UIColor whiteColor];
    takePhoto.frame = CGRectMake(30, 400, 50,50 );
    [takePhoto setTitle:@"拍照" forState:UIControlStateNormal];
    
    UIButton *finlish =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //takePhoto.backgroundColor = [UIColor whiteColor];
    finlish.frame = CGRectMake(140, 400, 50,50 );
    [finlish setTitle:@"完成" forState:UIControlStateNormal];
    
    UIButton *drawPhoto =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    drawPhoto.frame = CGRectMake(250, 400, 50, 50);
    [drawPhoto setTitle:@"绘图" forState:UIControlStateNormal];
    
    [takePhoto addTarget:self action:@selector(takeOnePhoto) forControlEvents:UIControlEventTouchUpInside];
    [finlish addTarget:self action:@selector(noteFinlish) forControlEvents:UIControlEventTouchUpInside];
    [drawPhoto addTarget:self action:@selector(drawOnePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:titleLable];
    [self.view addSubview:_noteTitle];
    [self.view addSubview:content];
    [self.view addSubview:takePhoto];
    [self.view addSubview:finlish];
    [self.view addSubview:drawPhoto];
    
    //[takePhoto]
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
{
    [textView resignFirstResponder];
    return YES;
}

-(void) takeOnePhoto
{
    //NSLog(@"do takeOnePhoto");
    TakePhotoViewController *TpVC =[[TakePhotoViewController alloc]init];
    [self.navigationController pushViewController:TpVC animated:YES];
    
    
}
-(void) noteFinlish
{
    appDelegate =[[UIApplication sharedApplication]delegate];
    appContext =[appDelegate managedObjectContext];
    
    if(![_notetext.text isEqualToString:@""] && ![_noteTitle.text isEqualToString:@""])
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        MyNote *oneNote = [NSEntityDescription insertNewObjectForEntityForName:@"MyNote" inManagedObjectContext:appContext];
        NSDate * noteDate = [NSDate date];
        NSString *noteDateS = [self dateToNSString:noteDate];
        oneNote.note_date = noteDateS;
        oneNote.note_title = _noteTitle.text;
        oneNote.note_Text = _notetext.text;

        for(int i = 0;i <[_ImageArray count];i++)
        {
            NSDate * newDate = [NSDate date];
            NSString *imageName = [self dateToNSString:newDate];
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
            // 保存文件的名称
            BOOL result = [UIImagePNGRepresentation ([_ImageArray objectAtIndex:i])writeToFile: filePath atomically:YES]; // 保存成功会返回YEs
               // NSLog(@"%@,%d",filePath,result);
            if(result)
            {
                ImageData* oneImage=[NSEntityDescription insertNewObjectForEntityForName:@"ImageData" inManagedObjectContext:appContext];
                oneImage.image_path = [imageName stringByAppendingFormat:@".png"];
                [oneNote addNoteAndImageObject:oneImage];
                
            }

            
        }
        NSError* error;
        [appContext save:&error];
        if (error!=nil) {
            NSLog(@"%@",error);
        }
        else
            NSLog(@"Yes");
                
    }
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void) drawOnePhoto
{
    NSLog(@"do drawOnePhoto");
    DrawPhotoViewController *DpVC =[[DrawPhotoViewController alloc]init];
    DpVC.delegate =self;
    [self.navigationController pushViewController:DpVC animated:YES];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"@image = %@",[_ImageArray lastObject]);
    if([_ImageArray count] != 0)
        return [_ImageArray count];
    else
    {
        //[_imageTable deleteSections:[NSIndexSet indexSetWithIndex:section]withRowAnimation:UITableViewRowAnimationLeft];
        return 0;
        
    }

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
    image.image = (UIImage *)[_ImageArray objectAtIndex:indexPath.row];

    return cell;
}
//cellHeigt
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}

-(void)passValue:(UIImage *)value
{
    [_ImageArray addObject:value];
    [_imageTable reloadData];
    NSLog(@"%@",[_ImageArray lastObject]);
}

-(NSString*)dateToNSString:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-hh-mm-ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
