//
//  ViewController.h
//  mynote
//
//  Created by Van on 14/11/16.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "AppDelegate.h"
#import "Notes.h"
@interface ViewController : UIViewController<UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>
- (void)keyboardWillShow:(NSNotification *)note;
- (void)buildCustomToolbar;
- (void)bold;
- (void)italic;
- (void)underline;
- (void)undo;
- (void)redo;
- (void)getHTML;
- (void) selectAlert;
- (IBAction)SaveNote:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationitem;
@property (weak, nonatomic) IBOutlet  UIView *v;
@property (retain, nonatomic) IBOutlet UIToolbar* toolBar;
@property (strong,nonatomic) AppDelegate *myDelegate;
@property NSManagedObjectContext *managedObjectContext;
@property BOOL isEdit;
@property Notes *note;
@end

