//
//  DrawNoteViewController.h
//  MyNotes
//
//  Created by alwaysking on 14/11/24.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "YYView.h"

@interface DrawNoteViewController : UIViewController

@property (strong, nonatomic)NSString *imageNameStr;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *btnClear;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,strong) NSFetchRequest *drawFetchRequest;
@property (weak, nonatomic) IBOutlet YYView *customView;

- (IBAction)btnCancle:(id)sender;
- (IBAction)btnOk:(id)sender;
- (NSString *)documentsPathForFileName:(NSString *)name;
- (IBAction)clearOnClick:(UIButton *)sender;
- (IBAction)backOnClick:(UIButton *)sender;


@end
