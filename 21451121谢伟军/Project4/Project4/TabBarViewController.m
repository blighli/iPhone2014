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
        self.isInsert = YES;
        self.contentVC = [self.contentVC init];
        self.photoVC = [self.photoVC init];
        self.pictureVC = [self.pictureVC init];
    }
    else{
        self.isInsert = NO;
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
    if ([self.contentVC.notetitle.text isEqualToString:@""] && [self.contentVC.content.text isEqualToString:@""] ) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        self.note = [[Note alloc]init];
        self.note.notetitle = self.contentVC.notetitle.text;
        self.note.content = self.contentVC.content.text;
        self.note.photo = self.photoVC.note.photo;
        NSLog(@"%@",self.note.notetitle);
        
        if (self.isInsert) {
//            NSString *sql = @"insert into notes (notetitle , content , photo , picture , datetime ) values (? , ? , ? , ? , ?)";
//            [self.db executeQuery:sql , self.note.notetitle , self.note.content , self.note.photo , self.note.picture , self.note.datetime];
            
            NSLog(@"self.note not nil");
            NSString *sql = @"insert into notes (notetitle , content , photo) values (? , ? , ?)";
            [self.db executeUpdate:sql , self.note.notetitle ,self.note.content ,self.note.photo];
            

            
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
