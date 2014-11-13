//
//  ViewController.m
//  Project2
//
//  Created by jingcheng407 on 14-11-9.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *TextLabel;

@end

@implementation ViewController
int rFlag=0;
double memory=0;
+(double)myCal:(char[]) stored andn:(int) n{
    
    NSMutableArray *cal = [[NSMutableArray alloc] init];
    int i,x,y,result=0;
    for(i=0;i<n;i++)
    {
        if(stored[i]=='+'||stored[i]=='\x12'||stored[i]=='\xd7'||stored[i]=='\xf7'||stored[i]=='%')//遇到运算符
        {
            y=[[cal lastObject] integerValue];
            [cal removeLastObject];
            x=[[cal lastObject] integerValue];
            [cal removeLastObject];
            switch(stored[i])//各种运算
            {
                case '+':result=x+y;break;
                case '\x12':result=x-y;break;
                case '\xd7':result=x*y;break;
                case '\xf7':result=x/y;break;
                case '%':result=x%y;
            }
            [cal addObject:[NSNumber numberWithInt:result]];
        }
        else
            [cal addObject:[NSNumber numberWithChar:stored[i]-'0']];
    }
    return result;
}
+(double)transform:(char[]) s andStored:(char[]) stored{
    const int a[8]={-1,-1,2,1,0,1,0,2};//保存优先级
    int i,j,temp;
    NSMutableArray *sk = [[NSMutableArray alloc] init];
    
    for(i=0,j=0,temp=0;s[i]!='\0';i++)//j保存数组stored的有效数字的长度
    {
        if(s[i]>='0'&&s[i]<='9')
            temp=temp*10+s[i]-'0';
        else
        {
            if(temp!=0)
            {
                stored[j++]=temp+'0';
                temp=0;
            }
            if([sk count]!=0&&[[sk lastObject] isEqualToString:@")"])
                [sk removeLastObject];
            if([sk count]==0)//空就放入
            {
                [sk addObject:[NSString stringWithFormat:@"%c",s[i]]];
            }
            
            
            else
            {
                char cp=[[sk lastObject] characterAtIndex:0];
                if(a[s[i]-'(']==a[cp -'('])
                    
                {
                    stored[j++]=cp;
                    [sk removeLastObject];
                    [sk addObject:[NSString stringWithFormat:@"%c",s[i]]];
                }
                else
                {
                    char cp=[[sk lastObject] characterAtIndex:0];
                    if((a[s[i]-'(']<a[cp-'(']&&s[i]!='(')||s[i]==')')
                    {
                        while([sk count]!=0 && cp!='(')//停止标志
                        {
                            stored[j++]=cp;
                            [sk removeLastObject];
                        }
                        if([sk count]!=0)
                            [sk removeLastObject];
                        [sk addObject:[NSString stringWithFormat:@"%c",s[i]]];
                    }
                    else
                        [sk addObject:[NSString stringWithFormat:@"%c",s[i]]];
                }
            }
        }
    }
    stored[j++]=temp+'0';//最后的数字也要拿
    while([sk count]!=0)//剩下的运算符
    {
        char cp=[[sk lastObject] characterAtIndex:0];
        stored[j++]=cp;
        [sk removeLastObject];
    }
    return j;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)equalButton:(id)sender {//等号，计算结果
    char s[1000]="";
    char stored[1000]="";
    int n,result;
    NSString *str=self.TextLabel.text;
    for(int i=0;i<str.length;i++){
        s[i]=[str characterAtIndex:i];
    }
    n=[ViewController transform:s andStored:stored];
    result=[ViewController myCal:stored andn:n];
    self.TextLabel.text =[NSString stringWithFormat:@"%d",result];
    rFlag=1;
}
- (IBAction)Button0:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"0";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"0"];
    }
    rFlag=0;}

- (IBAction)Button1:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"1";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"1"];
    }
    rFlag=0;
}

- (IBAction)Button2:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"2";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"2"];
    }
    rFlag=0;
}

- (IBAction)Button3:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"3";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"3"];
    }
rFlag=0;
}

- (IBAction)Button4:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"4";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"4"];
    }
    rFlag=0;
}

- (IBAction)Button5:(id)sender {
   if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"5";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"5"];
    }
    
    rFlag=0;
}

- (IBAction)Button6:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"6";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"6"];
    }
    rFlag=0;
}

- (IBAction)Button7:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"7";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"7"];
    }
    rFlag=0;
}

- (IBAction)Button8:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"8";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"8"];
    }
    rFlag=0;
}

- (IBAction)Button9:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"9";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"9"];
    }
    rFlag=0;
}

- (IBAction)ButtonDot:(id)sender {
    
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"."];
}

- (IBAction)ButtonAdd:(id)sender {
    
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"+"];
}

- (IBAction)ButtonSubtract:(id)sender {
    
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"−"];
}

- (IBAction)ButtonMultiply:(id)sender {
    
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"×"];
}

- (IBAction)ButtonDivide:(id)sender {
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"÷"];
}

- (IBAction)ButtonSign:(id)sender {
    
}

- (IBAction)ButtonAC:(id)sender {
    self.TextLabel.text = @"0";
}

- (IBAction)ButtonMC:(id)sender {
    memory=0;
}

- (IBAction)ButtonMAdd:(id)sender {
    memory=memory+[self.TextLabel.text doubleValue];
}

- (IBAction)ButtonMSubtract:(id)sender {
    memory=memory-[self.TextLabel.text doubleValue];}

- (IBAction)ButtonMR:(id)sender {
    self.TextLabel.text =[NSString stringWithFormat:@"%f",memory];
}

- (IBAction)ButtonDel:(id)sender { //删除按钮
    if (![self.TextLabel.text isEqualToString:@"0"]) {
        if(self.TextLabel.text.length!=1){
            self.TextLabel.text = [self.TextLabel.text substringWithRange:NSMakeRange(0,self.TextLabel.text.length-1)];
        }
        else{
            self.TextLabel.text = @"0";
        }
    }
}

- (IBAction)ButtonPercent:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"%"];
    }else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"%"];
    }
    rFlag=0;
}

- (IBAction)ButtonLeftBracket:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
   
        self.TextLabel.text = @"(";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"("];
    }
    rFlag=0;
}

- (IBAction)ButtonRightBracket:(id)sender {
    if (rFlag==1||[self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @")";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@")"];
    }
        rFlag=0;
}


@end
