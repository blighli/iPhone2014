//
//  GrooveTableViewController.m
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/22.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "GrooveTableViewController.h"
#import "MyTableViewCell.h"
#import "AFNetworking.h"
@interface GrooveTableViewController ()

@property (weak, nonatomic) IBOutlet UIView *grooveView;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (nonatomic) NSUInteger keyboardHeight;
@property (weak, nonatomic) IBOutlet UITextField *firstField;
@property (weak, nonatomic) IBOutlet UITextField *secondField;
@property (weak, nonatomic) IBOutlet UITextField *thirdField;
@property (nonatomic, strong) UIControl *backImageView;
@property (strong, nonatomic) NSString *username;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

static  NSString *cellIdentifier = @"CrossCell";

@implementation GrooveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reviewArray = [NSMutableArray array];
    [self configureUser];
    [self updateReview];
    
    
    _firstField.delegate = _secondField.delegate = _thirdField.delegate = self;
    //背景设置
    self.view.layer.contents = (id)[[UIImage imageNamed:@"tableback.png"] CGImage];
    _myView.layer.contents = (id)[[UIImage imageNamed:@"tableback.png"] CGImage];
    //键盘操作
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
}

- (void) updateReview
{
    [_reviewArray removeAllObjects];
    NSDictionary *dict = @{@"topicID":_topicID,
                           @"topicName":_topicName
                           };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://localhost:8080/Groose/main/reviewlist.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *reviewList = (NSArray *)responseObject;
        for (NSDictionary *reviewDict in reviewList) {
            [_reviewArray addObject:[reviewDict objectForKey:@"reviewContent"]];
        }
        [_myTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)configureUser
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.username = [user objectForKey:@"username"];
}
#pragma mark keyboard 
- (void)keyboardWillShow:(NSNotification *)notification
{
    self.backImageView = [[UIControl alloc] initWithFrame:self.myView.bounds];
    self.backImageView.backgroundColor = [UIColor blackColor];
    self.backImageView.alpha = 0.6f;
    self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.myView addSubview:_backImageView];
    [self.backImageView addTarget:self action:@selector(backTap) forControlEvents:UIControlEventTouchDown];

    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _keyboardHeight = keyboardRect.size.width;
    CGRect grooveFram = self.view.frame;
    grooveFram.size = CGSizeMake(grooveFram.size.width, grooveFram.size.height - _keyboardHeight + _grooveView.frame.size.height +15);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:grooveFram];
    [UIView commitAnimations];
    
}

- (void)backTap
{
    [_firstField resignFirstResponder];
    [_secondField resignFirstResponder];
    [_thirdField resignFirstResponder];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    CGRect grooveFram = self.view.frame;
    grooveFram.size = CGSizeMake(grooveFram.size.width, grooveFram.size.height + _keyboardHeight - _grooveView.frame.size.height -15);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:grooveFram];
    [UIView commitAnimations];
}


- (IBAction)kingButton:(id)sender {
    [self.reviewArray removeAllObjects];
    [_firstField resignFirstResponder];
    [_secondField resignFirstResponder];
    [_thirdField resignFirstResponder];
    NSString *kingString = [NSString stringWithFormat:@"%@%@%@",_firstField.text,_secondField.text,_thirdField.text];
    NSLog(@"%@ %@ %@",_firstField.text,_secondField.text,_thirdField.text);
    
    NSDictionary *dict = @{@"topicID":self.topicID,
                           @"topicName":self.topicName,
                           @"reviewContent":kingString
                           };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://localhost:8080/Groose/main/insertReview" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self updateReview];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [self.reviewArray addObject:kingString];
    [self.myTableView reloadData];
    _firstField.text = _secondField.text = _thirdField.text = @"";
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.reviewArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row % 2 == 0) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize size = CGSizeMake(rect.size.width, 55.0f);
        return size.height;
//    }else{
//        CGRect rect = [[UIScreen mainScreen] bounds];
//        CGSize size = CGSizeMake(rect.size.width, 0.3f);
//        return size.height;
//    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (indexPath.row % 2 == 0) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.image = [UIImage imageNamed:@"background.jpg"];
        cell.review = [_reviewArray objectAtIndex:indexPath.row];
        cell.groove = @"0";
        cell.username = _username;
        UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
        [cell setBackgroundView:backImage];
//    }else{
//        cell.review = @"";
//        cell.groove = @"";
//        cell.username = @"";
//        cell.cButton.hidden = NO;
//    }
//   
    
    return cell;
}

- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

#pragma mark - m MytableViewCellDelegate

- (void)MyTableViewCellButtonClickCell:(MyTableViewCell *)cell andCountLabel:(UILabel *)countLabel
{
    NSUInteger count = (NSUInteger) countLabel.text;
    count ++;
    countLabel.text = [NSString stringWithFormat:@"%lu",count];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 0) {
        textField.text = [textField.text substringToIndex:0];
        return YES;
    }else{
        return YES;

    }
}

@end
