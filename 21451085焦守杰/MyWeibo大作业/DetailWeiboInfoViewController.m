//
//  DetailWeiboInfoViewController.m
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/3.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "DetailWeiboInfoViewController.h"
#import "CommetViewController.h"
@interface DetailWeiboInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *replyBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailWeiboInfoViewController
@synthesize detailWeiboInfo;
- (void)viewDidLoad {
    [super viewDidLoad];
 //   NSLog(@"+++++++++++++++");
    _weibo=[Weibo getInstance];
    
    [self.tableView setDataSource: self];
    [self.tableView setDelegate: self];
    weiboID=[detailWeiboInfo objectForKey:@"mid"];
    NSThread *t=[[NSThread alloc]initWithTarget:self selector:@selector(loadData) object:nil];
    [t start];
    NSLog(@"%@+++++++",weiboID);
 //   commentArray=[_weibo getComment:weiboID];
    NSLog(@"%===============%@",commentArray);
    UIImage *image=[_weibo loadUIImage:[[detailWeiboInfo objectForKey:@"user"] objectForKey:@"avatar_large"]];
    [self.headBtn setBackgroundImage:image forState:UIControlStateNormal];
    self.headBtn.imageView.image=image;
    NSLog(@"%@",[[detailWeiboInfo objectForKey:@"user"] objectForKey:@"profile_image_url"]);
  //  if(image==nil)NSLog(@"ddfafaaaaaaaaa");
 //   self.headImage.image=[_weibo loadUIImage:[[detailWeiboInfo objectForKey:@"user"] objectForKey:@"profile_image_url"]];
 //   NSLog(@"%@",[[detailWeiboInfo objectForKey:@"user"] objectForKey:@"avatar_large"]);
    self.nameLabel.text=[[detailWeiboInfo objectForKey:@"user"] objectForKey:@"screen_name"];
    self.descriptionLabel.text=[[detailWeiboInfo objectForKey:@"user"] objectForKey:@"description"];
    self.timeLabel.text=[detailWeiboInfo objectForKey:@"created_at"];
    self.textView.text=[detailWeiboInfo objectForKey:@"text"];
    // Do any additional setup after loading the view.
}
-(void) loadData{
    commentArray=[_weibo getComment:weiboID];
    headImage=[[NSMutableArray alloc]initWithCapacity:[commentArray count]];
    for (int i=0; i<[commentArray count]; i++) {
        NSDictionary *d=commentArray[i];
//        Image *image=[_weibo loadUIImage:[[d objectForKey:@"user"] objectForKey:@"profile_image_url"]];
        [headImage addObject:[_weibo loadUIImage:[[d objectForKey:@"user"] objectForKey:@"profile_image_url"]]];
    }
    self.tableView.reloadData;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"commentCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if([commentArray count]>0){
        NSDictionary *d=commentArray[indexPath.row];
        cell.detailTextLabel.text=[d objectForKey:@"text"];
        cell.textLabel.text=[[d objectForKey:@"user"] objectForKey:@"name"];
        cell.imageView.image=headImage[indexPath.row];

    }
    return  cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   if(commentArray==nil)
       return 0;
    return [commentArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    CommetViewController *d=segue.destinationViewController;
//    d.id=[detailWeiboInfo objectForKey:@"id"];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
