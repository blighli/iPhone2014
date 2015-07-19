//
//  PhotoNoteViewController.m
//  AverNote
//
//  Created by Mz on 14-11-22.
//  Copyright (c) 2014年 mz. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "PhotoNoteViewController.h"
#import "Note.h"
#import "ViewController.h"
#import "Util.h"

@interface PhotoNoteViewController ()

@end

@implementation PhotoNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.sourceType];
        self.delegate = self;
        self.allowsEditing = YES;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [Util writeImageToFile:image withCompletion:^(BOOL didSuccess, NSString* imagePath) {
            if (didSuccess) {
                Note *note = [Note MR_createEntity];
                note.date = [NSDate date];
                note.content = imagePath;
                note.type = [NSNumber numberWithInt:NoteTypePhoto];
                [self.mainView.notes insertObject:note atIndex:0];
                [self.mainView.noteTable reloadData];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
        }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
