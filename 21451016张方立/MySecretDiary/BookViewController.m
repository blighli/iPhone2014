//
//  BookViewController.m
//  MySecretDiary
//
//  Created by icy on 14-12-22.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import "BookViewController.h"
#import "BookFrontView.h"
#import "BookBackView.h"
@interface BookViewController ()

@end

@implementation BookViewController

@synthesize user;
@synthesize frontView, backView;
@synthesize delegate;
@synthesize frontViewIsVisible;

-(id)initWithUser:(User *)u
{
    if (self = [super init])
    {
        self.user = u;
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    return self;
}



-(void)loadView{
    
    [super loadView];
    [self.view setClearsContextBeforeDrawing:YES];
    BookFrontView *bfw = [[BookFrontView alloc] initWithFrame:self.view.frame ];
    bfw.viewController = self;
    self.frontView = bfw;
    [self.view addSubview:self.frontView];
    
    BookBackView *bsw = [[BookBackView alloc] initWithFrame:self.view.frame];
    bsw.viewController = self;
    bsw.backgroundColor = [UIColor clearColor];
    self.backView = bsw;


}

-(void)viewWillAppear:(BOOL)animated
{
    [self.frontView refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setFrontView:nil];
    [self setBackView:nil];
    [self setUser:nil];
    [super viewDidUnload];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)configButtonSelected:(id)sender
{
    [self flipCurrentView];
}
-(void)backButtonSelected:(id)sender;
{
    [self flipCurrentView];

}
-(void)deleteButtonSelected:(id)sender
{
    switch ([sender tag])
    {
        case 0:
            [self.backView showPopOver];
            [self.backView.deleteButton setSelected:YES];
            break;
        case 1:
            [self.backView.deleteButton setSelected:NO];
            [self.delegate deleteThisBook:self];
            break;
        default:
            break;
    }
}
-(void)addNewButtonSelected
{
    [self.frontView.nameTextField setUserInteractionEnabled:YES];
    self.frontView.nameTextField.alpha = 1.0f;
    self.frontView.nameTextField.placeholder = @"Diary name";
    //  self.frontView.addNewButton.alpha = 0;
    //self.frontView.addNewButton = nil;
    //self.frontView.nameTextField.alpha = 1;
    
    [self.frontView.nameTextField becomeFirstResponder];
    [self.frontView hidePlusButton];
}
-(void)changeNamePressed
{
    [self.frontView.nameTextField setUserInteractionEnabled:YES];
    self.frontView.nameLabel.alpha = 0.0f;
    self.frontView.nameTextField.alpha = 1.0f;
    self.frontView.nameTextField.placeholder = @"Diary name";
    [self.frontView.nameTextField becomeFirstResponder];
    [self flipCurrentView];

}

-(void)flipCurrentView
{
    self.view.userInteractionEnabled = NO;
    
    
    // swap the views and transition
    if (frontViewIsVisible == YES)
    {
        [UIView transitionFromView:self.frontView
                            toView:self.backView
                          duration:0.75f
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        completion:^(BOOL finished){
                            self.view.userInteractionEnabled = YES;
                        }];
    }
    else
    {
        [UIView transitionFromView:self.backView
                            toView:self.frontView
                          duration:0.75f
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        completion:^(BOOL finished){
                            self.view.userInteractionEnabled = YES;
                        }];
    }
    
    frontViewIsVisible=!frontViewIsVisible;

}
-(void)refreshFrontView
{
    [self.frontView refresh];
}

#pragma mark - TextField Delegate Functions
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.frontView.nameLabel setAlpha:0.0f];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.frontView.nameLabel.text = textField.text;
    self.frontView.nameLabel.alpha = 1.0f;
    
    textField.text = @" ";
    [textField setUserInteractionEnabled:NO];
    [textField resignFirstResponder];
    [delegate nameBookFinishedWithName:frontView.nameLabel.text by:self];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
