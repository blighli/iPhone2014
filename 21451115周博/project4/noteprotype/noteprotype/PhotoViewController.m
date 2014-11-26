//
//  PhotoViewController.m
//  noteprotype
//
//  Created by zhou on 14/11/24.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "PhotoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CoreDataHelper.h"
#import "ApplicationConstants.h"
#import "AppDelegate.h"
#import "PhotoHelper.h"

@interface PhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *showCarmeraBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *savePhotoBtn;
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    self.imageView.clipsToBounds = YES;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = [appDelegate managedObjectContext];

    if (!self.isUpdate) {
        [self startCameraControllerFromViewController:self
                                        usingDelegate:self];
    }
    else
    {
        self.imageView.image = [self.photo getImage];
    }
   
}
- (IBAction)showCarmera:(id)sender {
    
    [self startCameraControllerFromViewController:self
                                    usingDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)startCameraControllerFromViewController:(UIViewController *)controller
                                  usingDelegate:(id<UIImagePickerControllerDelegate,
                                                    UINavigationControllerDelegate>)delegate
{
    if (([UIImagePickerController isSourceTypeAvailable:
                                      UIImagePickerControllerSourceTypeCamera] == NO) ||
        (delegate == nil) || (controller == nil))
        return NO;

    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;

    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
    // [UIImagePickerController availableMediaTypesForSourceType:
    // UIImagePickerControllerSourceTypeCamera];

    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = YES;

    cameraUI.delegate = delegate;

    // [controller presentModalViewController:cameraUI animated:YES];
    [self presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

// For responding to the user tapping Cancel.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    // [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

// For responding to the user accepting a newly-captured picture or movie
- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.capturedImage = image;
    
    [self.imageView setImage:self.capturedImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
    //[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if (sender == self.savePhotoBtn)
    {
        if (self.capturedImage != nil)
        {
            Photo *photo = (Photo *)[CoreDataHelper CreateEntityFactory:kPhoto inContext:self.context];

            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];

            photo.photoName = [[formatter stringFromDate:date] stringByAppendingPathExtension:@"png"];

            photo.photoOwner = self.note;

            NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

            NSURL *path = [docPath URLByAppendingPathComponent:photo.photoName];

           // NSLog(@"%@", path);

            photo.photoUrl = [path absoluteString];

            NSMutableSet *set = [self.note.photoContainer mutableCopy];
            [set addObject:photo];
           
            self.note.photoContainer = [NSSet setWithSet:set];

            [UIImagePNGRepresentation(self.capturedImage) writeToURL:path atomically:YES];
        }
    }
}

@end
