//
//  MyFriendViewController.m
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/2.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "MyFriendViewController.h"
#import "SendWeiboViewController.h"
#define urll @"https://api.weibo.com/2/statuses/friends_timeline.json"
#define accessToken @"2.00JTbjiCtsqKvB88efd0fb110knSqJ"
#define count @"20"
@interface MyFriendViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activatorIndictor;
@property (weak,nonatomic)UIActivityIndicatorView *activity;
@end

@implementation MyFriendViewController{
    
}
//@synthesize receiveData;
- (IBAction)clickSendWeiboButton:(id)sender {
    SendWeiboViewController *send=[self.storyboard instantiateViewControllerWithIdentifier:@"SendWeibo"];
    [self presentViewController:send animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _weibo=[Weibo getInstance];
    [self.view removeFromSuperview];
    [self.view.window addSubview:webVew];
    _isLoading=false;
    NSLog(@"%@",_weibo.finalPath);
    if(_weibo.user.token==nil)
        [self.navigationController performSegueWithIdentifier:@"registerSegue" sender:self];
    else{
        self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];//指定进度轮的大小
        [self.activity setCenter:CGPointMake(160, 140)];//指定进度轮中心点
        
        [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
        [self.activity startAnimating];
        NSString *s=[NSString stringWithFormat:@"%@?access_token=%@&count=%@",urll,accessToken,count];
        NSThread *t=[[NSThread alloc]initWithTarget:self selector:@selector(loadFriendWeibo:) object:s];
        [t start];
        NSLog(@"%@",_friendWeibo);
    }
}
-(void)viewWillAppear:(BOOL)animated{
    NSString *s=[NSString stringWithFormat:@"%@?access_token=%@&count=%@",urll,accessToken,count];
    NSThread *t=[[NSThread alloc]initWithTarget:self selector:@selector(loadFriendWeibo:) object:s];
    [t start];

}

-(void)loadFriendWeibo:(NSString *)s{
    _friendWeibo=[_weibo loadFriendWeibo:s];
    NSLog(@"%@",_friendWeibo);
    if(_friendWeibo!=nil)
        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];
}

-(void)updateUI{
    [self.activatorIndictor stopAnimating];
    self.tableView.hidden=NO;
    [self.tableView reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *d=[_weiboInfo objectAtIndex:indexPath.row];
     NSString *CellIdentifier = @"WeiboCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier ];
//    }
//    UIImageView *headImage=(UIImageView*)[cell viewWithTag:0];
//    headImage.image=[_weibo loadUIImage:[[d objectForKey:@"user"] objectForKey:@"profile_image_url"]];
//    UILabel *nameLabel=(UILabel *)[cell viewWithTag:1];
//    nameLabel.text=[[d objectForKey:@"user"] objectForKey:@"screen_name"];
//    UILabel *deviceLabel=(UILabel *)[cell viewWithTag:2];
//    deviceLabel.text=[d objectForKey:@"source"];
//    UILabel *timeLabel=(UILabel *)[cell viewWithTag:3];
//    timeLabel.text=[d objectForKey:@"created_at"];
//    UILabel *contentLabel=(UILabel *)[cell viewWithTag:4];
 //   contentLabel.text=[d objectForKey:@"text"];
 //   contentLabel.text=@"111111111111";
    BOOL nibRegistered = NO;
    NSLog(@"%@",nibRegistered);
    if (!nibRegistered) {
        UINib *nib = [UINib nibWithNibName:@"WeiboTableCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibRegistered = YES;
    }
    
    WeiboTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.headImage.image=[_weibo loadUIImage:[[d objectForKey:@"user"] objectForKey:@"profile_image_url"]];
    cell.timeLabel.text=[d objectForKey:@"created_at"];
    cell.contentLabel.text=[d objectForKey:@"text"];
    cell.nameLabel.text=[[d objectForKey:@"user"] objectForKey:@"screen_name"];
    cell.timeLabel.text=[d objectForKey:@"created_at"];
    cell.praiseCount=[d objectForKey:@"attitudes_count"];
    cell.commentCount=[d objectForKey:@"comments_count "];
    cell.retraCount=[d objectForKey:@"reposts_count"];
    
    
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//  
//    if (cell==nil) {
//        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WeiboTableCell" owner:self options:nil];
//        for(id oneObject in nib){
//            if([oneObject isKindOfClass:[WeiboTableCell class]]){
//                cell = (WeiboTableCell *)oneObject;
//            }
//        }
//    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _weiboInfo =[_friendWeibo objectForKey:@"statuses"];
 //   NSLog(@"%@",_friendWeibo);
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    dev=[self.storyboard instantiateViewControllerWithIdentifier:@"detailWeibo"];
    dev.detailWeiboInfo=[_weiboInfo objectAtIndex:index.row];
    [self.navigationController pushViewController:dev animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DetailWeiboInfoViewController *d=segue.destinationViewController;
    d.detailWeiboInfo=[_weiboInfo objectAtIndex:indexPath.row];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_isLoading) {
        float height = scrollView.contentSize.height > self.tableView.frame.size.height ? self.tableView.frame.size.height : scrollView.contentSize.height;
        
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
            
        }
        
        if (- scrollView.contentOffset.y / self.tableView.frame.size.height > 0.2) {
//            UIActivityIndicatorView *aiv=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//            [self.tableView addSubview:aiv];
//            aiv.hidden=NO;
//            aiv.color=[UIColor blackColor];
//            [aiv startAnimating];
   //         [self.activityIndicator startAnimating];
            NSString *s=[NSString stringWithFormat:@"%@?access_token=%@&count=%@",urll,accessToken,count];
            NSThread *t=[[NSThread alloc]initWithTarget:self selector:@selector(loadFriendWeibo:) object:s];
            [t start];
//            [aiv stopAnimating];
//            [aiv removeFromSuperview];
            NSLog(@"上啦刷新========");
        }
    }
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
