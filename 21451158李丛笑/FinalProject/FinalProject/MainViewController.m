//
//  MainViewController.m
//  FinalProject
//
//  Created by 李丛笑 on 15/1/5.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import "MainViewController.h"
#import "SetButton.h"
#import "ViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
int tableid=0;
NSArray *tablearray;

//- (void)viewDidLoad {
-(void)viewDidAppear:(BOOL)animated{
    [self loadView];
  //  mainscrollView = nil;
    SetButton *stb = [[SetButton alloc]init];
   // tablearray = [[NSMutableArray alloc]init];
    tablearray = [stb getTableArray];
  //  [super viewDidLoad];
    for (int i=0; i<[tablearray count]; i++) {
        [self createTableButton:[[tablearray objectAtIndex:i] intValue] Pos:i];
    }
    
  //  [self createTableButton];
    // Do any additional setup after loading the view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)createTableButton:(int)buttontag Pos:(int)pos{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"table" forState: UIControlStateNormal];

    button.frame = CGRectMake(50.f+pos*80.f, 50.f, 70.f, 50.f);;
    button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    button.clipsToBounds = YES;
    button.tag = buttontag;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(IBAction) buttonClicked:(UIButton *)sender {
     tableid =(int)sender.tag;
   [self performSegueWithIdentifier:@"toTableview" sender:self];
   
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController* view = segue.destinationViewController;
    NSString *ttag = [NSString stringWithFormat:@"%d",tableid];
    if ([segue.identifier isEqualToString:@"toTableview"]==YES) {
        ViewController *tableview =(ViewController *)view;
        [tableview setValue:ttag forKey:@"ttag"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addTable:(id)sender {
    NSLog(@"DDD");
    for (int i=0; i<100; i++) {
        NSString *tid = [NSString stringWithFormat:@"%d",i+1];
        if (![tablearray containsObject:tid]) {
            tableid = i+1;
           // [tablearray addObject:tableid];
            break;
        }
    }
    [self performSegueWithIdentifier:@"toTableview" sender:self];
    
}
@end
