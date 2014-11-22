//
//  NewNote.m
//  mynote
//
//  Created by Devon on 14/11/21.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import "NewNoteViewController.h"
#import "ViewController.h"
#import "Note.h"
#import "Paint.h"

@interface NewNoteViewController ()

@end

@implementation NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myAppDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.noteName becomeFirstResponder];
    self.noteName.delegate = self;
    self.noteContentText.layer.borderColor = UIColor.grayColor.CGColor;
    self.noteContentText.layer.borderWidth =1.0;
    self.noteContentText.layer.cornerRadius =5.0;
    self.noteContentText.delegate = self;
    self.noteContentImage.layer.borderColor = UIColor.grayColor.CGColor;
    self.noteContentImage.layer.borderWidth =1.0;
    self.noteContentImage.layer.cornerRadius =5.0;
    if (self.noteIndex != nil) {
        NSLog(@"NOT NULL ========");
        [self selectData:self.noteIndex];
    }
    else {
        NSLog(@"NULL =========");
        self.noteName.text = @"";
        self.noteContentText.text = @"";
        self.noteContentImage.image = nil;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([@"\n" isEqualToString:text] == YES) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)CallBack:(NSData *)data{
    self.noteContentImage.image = [UIImage imageWithData:data];
}

- (void)selectData:(NSString *)index {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* note=[NSEntityDescription entityForName:@"Note" inManagedObjectContext:_myAppDelegate.managedObjectContext];
    [request setEntity:note];
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",index];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[_myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult!=nil) {
        for(Note *note in mutableFetchResult){
            self.noteName.text = [note valueForKey:@"name"];
            self.noteContentText.text = [note valueForKey:@"c_text"];
            self.noteContentImage.image = [UIImage imageWithData:[note valueForKey:@"c_image"]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateData:(NSString *)nameIndex {
    NSFetchRequest* request=[[NSFetchRequest alloc] init];
    NSEntityDescription* note=[NSEntityDescription entityForName:@"Note" inManagedObjectContext:_myAppDelegate.managedObjectContext];
    [request setEntity:note];
    //查询条件
    NSPredicate* predicate=[NSPredicate predicateWithFormat:@"name==%@",self.noteIndex];
    [request setPredicate:predicate];
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[_myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult==nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
    for (Note* note in mutableFetchResult) {
        NSLog(@"*****************");
        [note setC_text:self.noteContentText.text];
        [note setC_image:UIImagePNGRepresentation(self.noteContentImage.image)];
    }
    [_myAppDelegate.managedObjectContext save:&error];
}

- (void)insertData:(NSString *)nameIndex {
    Note* note=(Note *)[NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    [note setName:self.noteName.text];
    [note setC_text:self.noteContentText.text];
    [note setC_image:UIImagePNGRepresentation(self.noteContentImage.image)];
    NSError* error;
    BOOL isSaveSuccess=[_myAppDelegate.managedObjectContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error:%@",error);
    }else{
        NSLog(@"Save successful!");
    }
    [_myAppDelegate.managedObjectContext save:&error];
}

- (IBAction)saveNewNote:(UIBarButtonItem *)sender {
    
    if (![self.noteName.text isEqualToString:@""]) {
        if(self.noteIndex != nil){
            NSLog(@"EXIST DATA");
            [self updateData:self.noteName.text];
        }
        else {
            NSLog(@"NOT EXIST DATA");
            [self insertData:self.noteIndex];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Prompt" message:@"Enter a name for this note" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{}];
}

- (IBAction)drawPhott:(UIButton *)sender {
    Paint *paint = [[Paint alloc] initWithNibName:@"Paint" bundle:nil];
    paint.delegate = self;
    [self.navigationController pushViewController:paint animated:YES];
}

- (IBAction)deletePhoto:(UIButton *)sender {
    self.noteContentImage.image = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    self.noteContentImage.image=image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end