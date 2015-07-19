//
//  NewNoteViewController.m
//  MySimpleNote
//
//  Created by 周舟 on 24/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "NewNoteViewController.h"
#import "Entity.h"
#import "DrawingViewController.h"

@interface NewNoteViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    int selected;
}


@property (weak, nonatomic) IBOutlet UIView             *canvesView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segement;
@property (weak, nonatomic) UITextView *textView;
@property (weak, nonatomic) DrawingViewController *drawVC;

@end

@implementation NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selected = 0;
    
    [self configView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.segement.selectedSegmentIndex = 0;
    [self.textView becomeFirstResponder];

}

- (void)configView
{
   
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    textView.backgroundColor = [UIColor grayColor];
    textView.textColor = [UIColor whiteColor];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tab:)];
    gesture.numberOfTapsRequired = 1;
    
    [textView addGestureRecognizer:gesture];
    
    [self.canvesView addSubview:textView];
    self.textView = textView;
    
    
}


- (void) tab:(UIGestureRecognizer *)recognizer
{
    if (self.textView.isFirstResponder)
    {
        [self.textView resignFirstResponder];
    }
    else
    {
        [self.textView becomeFirstResponder];
    }
}
- (IBAction)saveNote:(UIBarButtonItem *)sender
{
    if (selected == 0)
    {
        if (self.textView.text.length > 0)
        {
            Entity* entity;
            //创建一个新的Data类型note
            entity= (Entity *)[NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:self.manageedObjectContext];
            entity.content = self.textView.text;
            entity.date = [NSDate new];
            entity.imagepath = nil;
            
            //将数据写入
            NSError *error = nil;
            if (![entity.managedObjectContext save:&error])
            {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }
    else if(selected == 2)
    {
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)changSegment:(UISegmentedControl *)sender
{
    

    switch (sender.selectedSegmentIndex)
    {
        case 1:
        {
            UIStoryboard *draw = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            DrawingViewController *drwVC = [draw instantiateViewControllerWithIdentifier:@"draw"];
            
            drwVC.manageedObjectContext = self.manageedObjectContext;
            //[self presentViewController:drwVC animated:YES completion:nil];
            [self.navigationController pushViewController: drwVC animated:YES];
            break;
        }
        case 2:
        {
           
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
           
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //NSLog(@"piker:%@",info);
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString* imageDirPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString: @"/images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:imageDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHHmmss"];
    
    NSDate* nowDate = [NSDate new];
    NSString *imageFilePath = [imageDirPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate: nowDate], @"jpg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    //插入成功
    if ([imageData writeToFile:imageFilePath atomically:YES] ) {
        //声明新的Data变量
        Entity* entity;
        //创建一个新的Data类型note
        entity= (Entity *)[NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:self.manageedObjectContext];
        entity.content = nil;
        entity.date = [NSDate new];
        entity.imagepath = imageFilePath;
        
        //将数据写入
        NSError *error = nil;
        if (![entity.managedObjectContext save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
       
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"图片保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
    //[self popToRootViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //[picker popToRootViewControllerAnimated:YES];
}
    

@end
