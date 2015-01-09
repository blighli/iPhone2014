//
//  EditViewController.m
//  EasyCount
//
//  Created by yingxl1992 on 15/1/6.
//  Copyright (c) 2015年 21451043应晓立. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize username;
@synthesize record;
@synthesize flag;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if (flag==0) {
        titles=[[NSArray alloc]initWithObjects:@"早餐",@"午餐",@"晚餐",@"饮料",@"零食",@"交通",@"购物",@"娱乐",@"社交",@"衣物", nil];
    } else {
        titles=[[NSArray alloc]initWithObjects:@"薪水",@"奖金",@"补助费",@"投资",@"其它",nil];
    }
    types=[[NSArray alloc]initWithObjects:@"现金",@"银行卡", nil];
    
    //设置UICollectionView
    [self setUpCollection];
    
    
    //获取collectionview的默认背景色
    currentColor=[[UIColor alloc]init];
    currentColor=self.myCollection.backgroundColor;
    
    [self setUpTableData];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    //设置view的背景色
    color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backcolor"]];
    self.view.backgroundColor=color;
    
    UIBarButtonItem *saveBtn=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveRecord)];
    self.navigationItem.rightBarButtonItem=saveBtn;
    NSLog(@"edit:%ld",record.money);
    
    _moneyTextField.text=[NSString stringWithFormat:@"%ld",record.money];
}

- (void)setUpTableData{
    if (tableData==nil) {
        tableData=[[NSMutableArray alloc]init];
    }
    TableList *list1=[[TableList alloc]init];
    list1.imageName=@"des";
    list1.title=@"描述";
    list1.des=record.des;
    [tableData addObject:list1];
    TableList *list2=[[TableList alloc]init];
    list2.imageName=@"type";
    list2.title=@"账户";
    list2.des=[types objectAtIndex:record.accountType];
    [tableData addObject:list2];
}

- (void)saveRecord {
    //补充record
    NSInteger money=[_moneyTextField.text integerValue];
    record.money=money;
    
    NSString *recordStr=[self toJsonString:record];
    NSLog(@"%@",recordStr);
    NSURL *url;
    if (flag==0) {
        url=[NSURL URLWithString:@"http://localhost:8080/expend/edit"];
    } else {
        url=[NSURL URLWithString:@"http://localhost:8080/income/edit"];
    }
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    NSString *paramstr=[NSString stringWithFormat:@"record=%@",recordStr];
    NSData *params=[paramstr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:params];
    
    NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *res=[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"%@",res);
    
    if ([res compare:@"1"]==NSOrderedSame) {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"修改成功~" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertview show];
        alertView2=alertview;
    } else {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"修改失败，请重试~" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertview show];
    }
}

//Record转换成JSONString
- (NSString *)toJsonString:(Record *)rec {
    NSMutableString *str=[NSMutableString string];
    [str appendString:@"{"];
    [str appendString:[NSString stringWithFormat:@"\"id\":%ld,",rec.id]];
    [str appendString:[NSString stringWithFormat:@"\"username\":\"%@\",",rec.username]];
    [str appendString:[NSString stringWithFormat:@"\"addTime\":\"%@\",",rec.addTime]];
    [str appendString:[NSString stringWithFormat:@"\"money\":%ld,",rec.money]];
    [str appendString:[NSString stringWithFormat:@"\"des\":\"%@\",",rec.des]];
    [str appendString:[NSString stringWithFormat:@"\"type\":%ld,",rec.type]];
    [str appendString:[NSString stringWithFormat:@"\"accountType\":%ld,",rec.accountType]];
    [str appendString:[NSString stringWithFormat:@"\"year\":%ld,",rec.year]];
    [str appendString:[NSString stringWithFormat:@"\"month\":%ld,",rec.month]];
    [str appendString:[NSString stringWithFormat:@"\"day\":%ld",rec.day]];
    [str appendString:@"}"];
    return str;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

//设置UICollectionView
- (void)setUpCollection {
    self.dataMArr=[NSMutableArray array];
    NSInteger n;
    if (flag==0) {
        n=10;
    } else {
        n=5;
    }
    for (NSInteger i=0;i<n; i++) {
        NSString *imageName=[NSString stringWithFormat:@"%ld",i+1];
        UIImage *image=[UIImage imageNamed:imageName];
        NSString *title=[titles objectAtIndex:i];
        NSDictionary *dic=@{@"image":image,@"title":title};
        [self.dataMArr addObject:dic];
    }
    self.myCollection.delegate=self;
    self.myCollection.dataSource=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
    TableList *list=[tableData objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:list.imageName];
    cell.textLabel.text=list.title;
    cell.detailTextLabel.text=list.des;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"编辑描述" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        alertView.alertViewStyle=UIAlertViewStylePlainTextInput;
        UITextField *textField=[alertView textFieldAtIndex:0];
        textField.text=record.des;
        alertView1=alertView;
        [alertView show];
    } else {
        UIView *subView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
        DLRadioButton *firstRadioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        firstRadioButton.buttonSideLength = 30;
        [firstRadioButton setTitle:@"现金" forState:UIControlStateNormal];
        [firstRadioButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        firstRadioButton.circleColor = [UIColor yellowColor];
        firstRadioButton.indicatorColor = [UIColor yellowColor];
        firstRadioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [subView addSubview:firstRadioButton];
        
        DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(0, 40, 200, 30)];
        radioButton.buttonSideLength = 30;
        [radioButton setTitle:@"银行卡" forState:UIControlStateNormal];
        [radioButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        radioButton.circleColor = [UIColor yellowColor];
        radioButton.indicatorColor = [UIColor yellowColor];
        radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [subView addSubview:radioButton];
        firstRadioButton.otherButtons=[NSArray arrayWithObjects:radioButton, nil];
        self.buttomRadioButtons = [@[firstRadioButton] arrayByAddingObjectsFromArray:firstRadioButton.otherButtons];
        
        [(DLRadioButton *)self.buttomRadioButtons[record.accountType] setSelected:YES];
        
        CustomIOS7AlertView *alertView=[[CustomIOS7AlertView alloc]init];
        [alertView setContainerView:subView];
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"确定",@"取消", nil]];
        [alertView setDelegate:self];
        [alertView show];
    }
}

//设置CustomIOS7AlertView的点击事件
- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        NSString *buttonName = [(DLRadioButton *)self.buttomRadioButtons[0] selectedButton].titleLabel.text;
        if ([buttonName compare:@"现金"]==NSOrderedSame) {
            record.type=0;
        } else {
            record.type=1;
        }
    }
    tableData=nil;
    [self setUpTableData];
    [_tableView reloadData];
    [alertView close];
}

//设置UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataMArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier;
    if (indexPath.row%2==0) {
        identifier=@"myCollectionCell";
    } else {
        identifier=@"myCollectionCell2";
    }
    
    CollectionCell *cell=(CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *dic=self.dataMArr[indexPath.row];
    UIImage *image=[dic objectForKey:@"image"];
    NSString *title=[dic objectForKey:@"title"];
    cell.imageView.image=image;
    cell.titleLabel.text=title;
    if (indexPath.row==record.type) {
        cell.backgroundColor=[UIColor whiteColor];
        if (preCell!=nil) {
            preCell.backgroundColor=currentColor;
        }
        
        preCell=cell;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionCell *cell=(CollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    if (preCell!=nil) {
        preCell.backgroundColor=currentColor;
    }
    
    preCell=cell;
    record.type=indexPath.row;
}

//UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView==alertView1) {
        if (buttonIndex==1) {
            UITextField *textField=[alertView textFieldAtIndex:0];
            record.des=[textField text];
            tableData=nil;
            [self setUpTableData];
            [_tableView reloadData];
        }
    } else if (alertView==alertView2) {
        if (buttonIndex==1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

@end
