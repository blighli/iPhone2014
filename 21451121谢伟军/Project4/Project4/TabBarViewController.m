//
//  TabBarViewController.m
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewdidload--TabBarViewController");
    NSLog(@"%@",self.test);
    self.contentVC = [ContentViewController alloc];
    self.photoVC = [PhotoViewController alloc];
    self.pictureVC = [PictureViewController alloc];
    UIImage *image_content = [UIImage imageNamed:@"content.png"];
    self.contentVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"文本" image:image_content tag:0];
    UIImage *image_photo = [UIImage imageNamed:@"photo.png"];
    self.photoVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"照片" image:image_photo tag:1];
    UIImage *image_picture = [UIImage imageNamed:@"picture.png"];
    self.pictureVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"涂鸦" image:image_picture tag:2];
    
    
    if (self.note == nil) {
        self.isCreate = YES;
        self.contentVC = [self.contentVC init];
        self.photoVC = [self.photoVC init];
        self.pictureVC = [self.pictureVC init];
    }
    else{
        self.isCreate = NO;
        self.contentVC = [self.contentVC initWithNote:self.note];
        self.photoVC = [self.photoVC initWithNote:self.note];
        self.pictureVC = [self.pictureVC initWithNote:self.note];
    }
    self.viewControllers = @[self.contentVC , self.photoVC , self.pictureVC ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [viewController setValue:self.note forKey:@"note"];
    NSLog(@"currentController:%@ index:%lu",viewController,(unsigned long)tabBarController.selectedIndex);
    UIViewController  *currentController =tabBarController.selectedViewController;
    NSLog(@"currentController: %@",currentController);  }


- (IBAction)saveNote:(UIBarButtonItem *)sender {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yy/MM/dd HH:mm"];
    NSDate* nowDate = [[NSDate alloc] init];
    NSString *datetime = [dateFormatter stringFromDate:nowDate];
//    NSLog(@"%@",datetime);
    if ([self.contentVC.notetitle.text isEqualToString:@""] && [self.contentVC.content.text isEqualToString:@""] ) {
        //            [self.navigationController popViewControllerAnimated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注意" message:@"请输入文本信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    self.note = [[Note alloc]init];
    self.note.notetitle = self.contentVC.notetitle.text;
    self.note.content = self.contentVC.content.text;
    self.note.photo = self.photoVC.note.photo;
    self.note.picture = self.pictureVC.note.picture;
    self.note.datetime = datetime;
    //            NSString *sql = @"insert into notes (notetitle , content , photo , picture , datetime ) values (? , ? , ? , ? , ?)";
    //            [self.db executeQuery:sql , self.note.notetitle , self.note.content , self.note.photo , self.note.picture , self.note.datetime];
    if (self.isCreate) {
        NSLog(@"init a note");
        NSString *sql = @"insert into notes (notetitle , content , photo , picture , datetime) values (? , ? , ? , ? , ?)";
        [self.db executeUpdate:sql , self.note.notetitle ,self.note.content ,self.note.photo,self.note.picture , self.note.datetime];
    }
    //修改
    else{
        self.note.ID = self.contentVC.note.ID;
        NSLog(@"update a note");
        NSString *sql = @"update notes set notetitle = ? ,content = ? , photo =? , picture = ? , datetime = ? where id = ?";
        [self.db executeUpdate:sql , self.note.notetitle ,self.note.content ,self.note.photo,self.note.picture , self.note.datetime , [NSString stringWithFormat:@"%d",self.note.ID]];
//        NSString *sql = @"update notes set notetitle = 10086 where id = ?";
//        [self.db executeUpdate:sql , [NSString stringWithFormat:@"%d",self.note.ID]];
    }
    [self.navigationController popViewControllerAnimated:YES];

    
    
}
@end
