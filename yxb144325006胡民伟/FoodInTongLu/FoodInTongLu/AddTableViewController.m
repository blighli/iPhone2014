//
//  AddTableTableViewController.m
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/14.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "AddTableViewController.h"
#import "Restaurant.h"
#import "AppDelegate.h"

@interface AddTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) Restaurant *restaurant;
@property BOOL isVisited;
@end

@implementation AddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.isVisited = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.allowsEditing = false;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:true completion:nil];
        }
    }
    [tableView  deselectRowAtIndexPath:indexPath animated:true];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = chosenImage;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = true;
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)updateIsVisited:(id)sender{
    // Yes button clicked
    UIButton *buttonClicked = sender;
    if (buttonClicked == self.yesButton) {
        self.isVisited = true;
        self.yesButton.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:73.0/255.0 blue:27.0/255.0 alpha:1.0];
        self.noButton.backgroundColor = [UIColor grayColor];
    } else if(buttonClicked == self.noButton){
        self.isVisited = false;
        self.noButton.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:73.0/255.0 blue:27.0/255.0 alpha:1.0];
        self.yesButton.backgroundColor = [UIColor grayColor];
    }
}

- (void)saveRecordToCoreData:(NSString *)name andType:(NSString *)type andLocation:(NSString *)location andImage:(NSData *)image andIsVisited:(NSNumber *)isVisited{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    if (managedObjectContext) {
        Restaurant *newRestaurant = (Restaurant*)[NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:managedObjectContext];
        newRestaurant.name = name;
        newRestaurant.type = type;
        newRestaurant.location = location;
        newRestaurant.image = image;
        newRestaurant.isVisited = isVisited;
        
        NSError *error = nil;
        if ([managedObjectContext save:&error] != true) {
            NSLog(@"Insert error: %@",[error localizedDescription]);
            return;
        }
    }
}

- (void)saveRecordToCloud:(Restaurant*)restaurant{
    
}

- (IBAction)save:(id)sender {
    // Form validation
    NSString *errorField = @"";
    
    if ([self.nameTextField.text  isEqual:@""]) {
        errorField = @"name";
    }else if ([self.locationTextField.text  isEqual:@""]){
        errorField = @"location";
    }else if ([self.typeTextField.text isEqualToString:@""]){
        errorField = @"type";
    }
    
    if (![errorField isEqual: @""]) {
        NSMutableString *errorMessage = [[NSMutableString alloc]initWithString:@"We can't proceed as you forget to fill in the restaurant "];
        [errorMessage appendString:errorField];
        [errorMessage appendString:@". All fields are mandatory."];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                                 message:errorMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleDefault
                                                           handler:nil];
        [alertController addAction:doneAction];
        
        [self presentViewController:alertController animated:true completion:nil];
        return;
    }
        
    [self saveRecordToCoreData:self.nameTextField.text andType:self.typeTextField.text andLocation:self.locationTextField.text andImage:UIImagePNGRepresentation(self.imageView.image) andIsVisited:[NSNumber numberWithBool:self.isVisited]];
    
    //[self saveRecordToCloud:self.restaurant];
    
    // Execute the unwind segue and go back to the home screen
    [self performSegueWithIdentifier:@"unwindToHomeScreen" sender:self];
}
@end
