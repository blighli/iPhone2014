//
//  ThirdViewController.m
//  MyNotes
//
//  Created by 樊博超 on 14-11-14.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "ThirdViewController.h"
#import "DrawView.h"
#import "Database.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem* tbi = [self tabBarItem];
        [tbi setTitle:@"绘图"];
        
        UIImage* image = [UIImage imageNamed:@"text.png"];
        
        [tbi setImage:image];
        db = [[Database alloc] init];
    }
    
    
    CGRect nameField = CGRectMake(10, 80, 200, 31);
    drawNameView = [[UITextField alloc] initWithFrame:nameField];
    [drawNameView setPlaceholder:@"输入名字"];
    [drawNameView setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:drawNameView];
    
    CGRect drawFrame = CGRectMake(0, 113, 380, 510);
    drawview = [[DrawView alloc] initWithFrame:drawFrame];
    [self.view addSubview: drawview];
    
    CGRect buttonFrame = CGRectMake(228, 80, 72, 31);
    clear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clear setFrame:buttonFrame];
    [clear setTitle:@"Clear" forState:UIControlStateNormal];
    [clear addTarget:self
              action:@selector(clearDraw:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clear];
    
    CGRect saveFrame = CGRectMake(288, 80, 72, 31);
    save = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [save setFrame:saveFrame];
    [save setTitle:@"Save" forState:UIControlStateNormal];
    [save addTarget:self
             action:@selector(saveDraw:)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:save];
    
    
    
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)clearDraw:(id)sender{
    NSLog(@"clear pic");
    [drawview clear];
    return;
}

-(IBAction)saveDraw:(id)sender{
    NSLog(@"save pic");
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(drawview.frame.size, NO, 0.0);
    }
else {
        UIGraphicsBeginImageContext(drawview.frame.size);
    }
    [drawview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   
    NSData * data = [[NSData alloc] init];
    if (UIImagePNGRepresentation(img) == nil) {
        
        data = UIImageJPEGRepresentation(img, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(img);
    }
    [db openDatabase];
    [db createTable];
    [db insertTable:drawNameView.text withdata:data];
    [db closeDatabase];
    return;
}


-(void)setItem:(NoteData *)item{
    _item = item;
    drawNameView.text = _item.name;
    [db openDatabase];
    [db createTable];
    NoteData * temp = [[db queryLine:item.type withname:item.name] objectAtIndex:0];
    NSData * data = [[NSData alloc] initWithData:temp.pic];
    UIImage * img = [UIImage imageWithData:data];
    [drawview setBackgroundColor:[UIColor colorWithPatternImage:img]];
    [db closeDatabase];
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
