//
//  ViewController.m
//  mycalculate
//
//  Created by Frank Yuan on 11/3/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "stackforchar.h"
#import "stackfordouble.h"
@interface ViewController ()

- (IBAction)btnmjian:(id)sender;
- (IBAction)btnmr:(id)sender;
- (IBAction)btnclick:(id)sender;
- (IBAction)btnequal:(id)sender;
- (IBAction)btnac:(id)sender;
- (IBAction)btnmc:(id)sender;
- (IBAction)btnmjia:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lb_M;
@property (weak, nonatomic) IBOutlet UILabel *lb_expression;
@property (weak, nonatomic) IBOutlet UILabel *lb_result;
@property double memory;

@end

BOOL ErrorOccured=NO;
NSString* ErrorDisc=@"";
double Memory=0;
double LastResult=0;

BOOL IsOpt(char c){
    if(c=='+' || c=='-' || c=='*' || c=='/')return YES;
    return NO;
}
int priority(char c){
    switch (c) {
        case '#':
            return -1;
            break;
        case '(':
            return 0;
            break;
        case '-':
        case '+':
            return 1;
            break;
        case '*':
        case '/':
            return 2;
            break;
    }
    return -1;
}
void CreatePostExp(NSString* expression,char postExp[],int *n){
    BOOL LastIsOpt=NO;
    int i=0,j=0;
    char ch;
    stackforchar* mystack=[[stackforchar alloc]init];
    [mystack push:'#'];
    while (i<[expression length]) {
        ch=[expression characterAtIndex:i];
        if((ch<='9' && ch>='0')|| ch=='.' ){
            postExp[j]=ch;
            j++;
            (*n)++;
            LastIsOpt=NO;
        }else if(ch=='('){
            [mystack push:ch];
            LastIsOpt=NO;
        }else if(ch==')'){
            LastIsOpt=NO;
            while([mystack gettop]!='('){
                postExp[j]=[mystack pop];
                j++;
                (*n)++;
            }
            [mystack pop];
        }else if(IsOpt(ch)){
            if(LastIsOpt){
                ErrorOccured=YES;
                ErrorDisc=@"错误:连续操作符";
                return;
            }
            LastIsOpt=YES;
            postExp[j]=' ';
            j++;
            (*n)++;
            while(priority(ch)<=priority(mystack.gettop)){
                postExp[j++]=[mystack pop];
                (*n)++;
            }
            [mystack push:ch];
        }
        i++;
    }
    while(![mystack IsEmpty]){
        char tmp=[mystack pop];
        if(tmp=='('){
            ErrorOccured=YES;
            ErrorDisc=@"括号不匹配";
        }
        postExp[j++]=tmp;
        (*n)++;
    }
}

double readnumber(char str[],int *i){
    double x=0.0f;
    int j=0;
    while(str[*i]>='0' && str[*i]<='9'){
        x=x*10+(str[*i]-'0');
        (*i)++;
    }
    if(str[*i]=='.'){
        (*i)++;
        while((str[*i]>='0' && str[*i]<='9')|| str[*i]=='.'){
            if(str[*i]=='.'){
                ErrorOccured=YES;
                ErrorDisc=@"错误:多余小数点";
                return 0;
            }
            x=x*10+(str[*i]-'0');
            (*i)++;
            j++;
        }
    }
    while(j!=0){
        x/=10.0f;
        j--;
    }
    return x;
}

double compute(char postExp[]){
    if (ErrorOccured) {
        return 0;
    }
    double result=0;
    stackfordouble* mystack=[[stackfordouble alloc]init];
    int i=0;
    double x1,x2;
    while (postExp[i]!='#') {
        if(postExp[i]>='0' && postExp[i]<='9'){
            [mystack push:readnumber(postExp, &i)];
            if (ErrorOccured) {
                return 0;
            }
        }else if(postExp[i]==' '){
            i++;
        }else if(postExp[i]=='+'){
            x2=[mystack pop];
            x1=[mystack pop];
            [mystack push:x1+x2];
            i++;
        }else if (postExp[i]=='-'){
            x2=[mystack pop];
            x1=[mystack pop];
            [mystack push:x1-x2];
            i++;
        }else if (postExp[i]=='*'){
            x2=[mystack pop];
            x1=[mystack pop];
            [mystack push:x1*x2];
            i++;
        }else if (postExp[i]=='/'){
            x2=[mystack pop];
            x1=[mystack pop];
            [mystack push:x1/(x2+0.0f)];
            i++;
        }
    }
    result=[mystack gettop];
    return result;
}

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMemory:0.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnclick:(id)sender {
    UIButton* btn=sender;
    NSString* str=[btn currentTitle];
    //NSLog(@"%@",str);
    
    NSString* currentstr=[[self lb_expression]text];
    NSString* string=[[NSString alloc]initWithFormat:@"%@%@",currentstr,str ];
    //NSLog(@"%@",string);
    [self lb_expression].text=string;
}
-(void)Calculate{
    char postExp[100]={' '};
    int n=0;
    CreatePostExp([self lb_expression].text,postExp,&n);
    NSLog(@"%s",postExp);
    double result=compute(postExp);
    LastResult=result;
    NSLog(@"Result is %f",LastResult);
}
-(void)ShowResult{
    int ans=LastResult;
    if(ans==LastResult){
        [self lb_result].text=[[NSString alloc]initWithFormat:@"%d",ans];
    }else
        [self lb_result].text=[[NSString alloc]initWithFormat:@"%f",LastResult];
}
- (IBAction)btnequal:(id)sender {
    [self Calculate];
    if (ErrorOccured) {
        [self lb_result].text=[[NSString alloc]initWithString:ErrorDisc];
    }else{
        [self ShowResult];
    }
}

- (IBAction)btnac:(id)sender {
    [self lb_expression].text=@"";
    [self lb_result].text=@"0";
    ErrorOccured=NO;
    ErrorDisc=@"";
}

- (IBAction)btnmc:(id)sender {
    Memory=0;
    [self lb_M].text=@"";
}

- (IBAction)btnmjia:(id)sender {
    
    [self lb_M].text=@"M";
    [self Calculate];
    Memory+=LastResult;
}
- (IBAction)btnmjian:(id)sender {
    [self lb_M].text=@"M";
    [self Calculate];
    Memory-=LastResult;
}

- (IBAction)btnmr:(id)sender {
    int ans=Memory;
    if(ans==Memory){
        [self lb_result].text=[[NSString alloc]initWithFormat:@"%d",ans];
    }else
        [self lb_result].text=[[NSString alloc]initWithFormat:@"%f",Memory];
}
@end








