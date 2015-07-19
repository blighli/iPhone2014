//
//  PhotoViewController.m
//  MyNotes
//
//  Created by liug on 14-11-15.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "PhotoViewController.h"
#import "sqlite3.h"
#import "CreateViewController.h"
#import "EditDrawController.h"
NSIndexPath * indexpath;
@interface PhotoViewController ()

@end

@implementation PhotoViewController
@synthesize phototable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    tasklist = [[NSMutableArray alloc] init];
    CreateViewController *cvc=[[CreateViewController alloc]init];
    [cvc openDB];
    [cvc createDrawTableNamed:@"MyPhotos" withField1:@"path"];
    [cvc getAllRowsFromDraw:@"MyPhotos" and:tasklist];
    [phototable reloadData]; //表格视图重新载入数据
}- (void)viewDidLoad
{
    UIBarButtonItem *newphotos=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=newphotos;
    [super viewDidLoad];
    [phototable setDataSource:self];
    [phototable setDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)add{
   
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"error" message:@"no support" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil, nil] show];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString* imageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHHmmss"];
    
    CreateViewController *cvc=[[CreateViewController alloc]init];
    [cvc openDB];

    NSString *imageFilePath = [imageDirPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate: [NSDate date]], @"png"];
    [UIImagePNGRepresentation(image) writeToFile:imageFilePath atomically:YES];
    
    [cvc insertDrawIntoTableNamed:@"MyPhotos" withField1:@"path" field1Value:imageFilePath];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasklist count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [phototable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasklist objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}
//section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"All photos";
}
/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CreateViewController *cvc=[[CreateViewController alloc]init];
        [cvc openDB];
        [cvc deleteDrawfromTableNamed:@"MyPhotos" withField1:@"path" field1Value:tasklist[indexPath.row]];
        [tasklist removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [phototable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexpath=indexPath;
    EditDrawController *newview=[[EditDrawController alloc]init];
    newview .path=tasklist[indexPath.row];
    [self.navigationController pushViewController:newview animated:YES];
}

@end
