//
//  ViewController.m
//  Computer Version2
//
//  Created by Steve on 14-11-10.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
       [super viewDidLoad];
    //self.string=[[NSMutableString alloc]init];//初始化可变字符串，分配内存
    //self.str = [[NSString alloc]init];

    // Do any additional setup after loading the view, typically from a nib.
    memset(str, 0, sizeof(str));
    temp=0;
    count =0;
    num1=0;
    num2=0;
    string =[[NSMutableString alloc] init];
}
-(void) chartostring
{
    for (int i=0; i<count; i++) {
        NSLog(@"%c",str[i]);
    }
    string =[[NSMutableString alloc] init];
    [string appendFormat:@"%s",str ];
    textField.text=string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)MC{
    textField.text=@"MC";
    temp=0;
}
-(void)Mjia{
    
    num1=atof(str);
    temp+=num1;
    count=0;
    memset(str, 0, sizeof(str));
    [self chartostring];
    textField.text=@"M+";
}
-(void)Mjian{
    temp-=num1;
    count=0;
    memset(str, 0, sizeof(str));
    [self chartostring];
    textField.text=@"M-";

}
-(void)MR{
    textField.text=@"MR";
    string = [NSString stringWithFormat:@"%f",temp];
    textField.text=string;
}
-(void)Back{
    if (count!=0) {
        str[count-1]=0;
        count--;
    }
    [self chartostring];
}
-(void)kuohao1{
    if (count<100) {
        str[count++]='(';
    }
    [self chartostring];
    
}
-(void)kuohao2{
    if (count<100) {
        str[count++]=')';
    }
    [self chartostring];

}
-(void)quyu{
    num1=atof(str);
    string = [NSString stringWithFormat:@"%f",num1/100];
    textField.text=string;
    memset(str, 0, sizeof(str));
    count=0;
}
-(void)AC{
    count=0;
    memset(str, 0, sizeof(str));
    [self chartostring];
}
-(void)chu{
    if (count<100) {
        str[count++]='/';
    }
    [self chartostring];
}
-(void)cheng{
    if (count<100) {
        str[count++]='*';
    }
    [self chartostring];
}
-(void)jian{
    if (count<100) {
        str[count++]='-';
    }
    [self chartostring];
}
-(void)jia{
    if (count<100) {
        str[count++]='+';
    }
    [self chartostring];
}
-(void)number1{
    if (count<100) {
        str[count++]='1';
    }
    [self chartostring];
}
-(void)number2{
    if (count<100) {
        str[count++]='2';
    }
    [self chartostring];
}
-(void)number3{
    if (count<100) {
        str[count++]='3';
    }
    [self chartostring];
}
-(void)number4{
    if (count<100) {
        str[count++]='4';
    }
    [self chartostring];
}
-(void)number5{
    if (count<100) {
        str[count++]='5';
    }
    [self chartostring];
}
-(void)number6{
    if (count<100) {
        str[count++]='6';
    }
    [self chartostring];
}
-(void)number7{
    if (count<100) {
        str[count++]='7';
    }
    [self chartostring];
}
-(void)number8{
    if (count<100) {
        str[count++]='8';
    }
    [self chartostring];
}
-(void)number9{
    if (count<100) {
        str[count++]='9';
    }
    [self chartostring];
}
-(void)number0{
    if (count<100) {
        str[count++]='0';
    }
    [self chartostring];
}
-(void)dian{
    if (count<100) {
        str[count++]='.';
    }
    [self chartostring];
}
-(void)deng{
    
        int i=0,j,k,m,cnt=0,t1=0,t2=0,t3=0;
        char nibo[50],zhan2[50];
        double x,n,l,z=0,zhan3[50];
        typedef struct
        {
            double d1;
            
            int d2;
        }dd;
        typedef struct
        {
            dd data[50];
            int top;
        }zhan1;
        zhan1 *shu;
        shu=(zhan1 *)malloc(sizeof(zhan1));
        shu->top=0;
        while(str[i]!=0)
        {
            if(str[i]>='0'&&str[i]<='9')
            {
                z=0;
                j=i+1;
                while(str[j]>='0'&&str[j]<='9')
                {j++;}
                j--;
                for(k=i;k<=j;k++)
                {
                    z=z*10+str[k]-'0';
                }
                j=j+1;
                x=z;
                if(str[j]=='.')
                {
                    l=1;
                    i=j+1;
                    j=i+1;
                    while(str[j]>='0'&&str[j]<='9')
                    {j++;}
                    j--;
                    for(k=i;k<=j;k++)
                    {
                        n=pow(0.1,l);
                        l=l+1;
                        x=x+n*(str[k]-'0');
                    }
                    i=j+1;
                }
                else i=j;
                shu->data[++shu->top].d1=x;
                shu->data[shu->top].d2=++cnt;
                nibo[++t1]='0'+shu->data[shu->top].d2;
                nibo[t1+1]=0;
            }
            else if(str[i]=='(')
            {
                zhan2[++t2]=str[i];
                i++;
            }
            else if(str[i]==')')
            {
                j=t2;
                while(zhan2[j]!='(')
                {
                    nibo[++t1]=zhan2[j];
                    nibo[t1+1]=0;
                    j--;
                }
                t2=j-1;
                i++;
            }
            else if(str[i]=='+')
            {
                while(t2>0&&zhan2[t2]!='(')
                {
                    nibo[++t1]=zhan2[t2];
                    nibo[t1+1]=0;
                    t2--;
                }
                zhan2[++t2]=str[i];
                i++;
            }
            else if(str[i]=='-')
            {
                if(str[i-1]=='$')
                {
                    str[0]='0';
                    i=0;
                }
                else if(str[i-1]=='(')
                {
                    str[i-1]='0';
                    str[i-2]='(';
                    i=i-2;
                    t2--;
                }
                else
                {
                    while(t2>0&&zhan2[t2]!='(')
                    {
                        nibo[++t1]=zhan2[t2];
                        nibo[t1+1]=0;
                        t2--;
                    }
                    zhan2[++t2]=str[i];
                    i++;
                }
            }
            else if(str[i]=='*'||str[i]=='/')
            {
                while(zhan2[t2]=='*'||zhan2[t2]=='/'||zhan2[t2]=='^'||zhan2[t2]=='#')
                {
                    nibo[++t1]=zhan2[t2];
                    nibo[t1+1]=0;
                    t2--;
                }
                zhan2[++t2]=str[i];
                i++;
            }
            else if(str[i]=='^'||str[i]=='#')
            {
                while(zhan2[t2]=='^'||zhan2[t2]=='#')
                {
                    nibo[++t1]=zhan2[t2];
                    nibo[t1+1]=0;
                    t2--;
                }
                zhan2[++t2]=str[i];
                i++;
            }
        }
        while(t2>0)
        {
            nibo[++t1]=zhan2[t2];
            nibo[t1+1]=0;
            t2--;
        }
        
        j=1;t3=0;
        while(j<=t1)
        {
            if(nibo[j]>='0'&&nibo[j]!='^'&&nibo[j]!='#')//
            {
                for(i=1;i<=shu->top;i++)
                {
                    if((int)(nibo[j]-'0')==shu->data[i].d2)
                    {
                        m=i;
                        break;
                    }
                }
                zhan3[++t3]=shu->data[m].d1;
                
            }
            else if(nibo[j]=='+')
            {
                zhan3[t3-1]=zhan3[t3-1]+zhan3[t3];
                t3--;
                
            }
            else if(nibo[j]=='-')
            {
                zhan3[t3-1]=zhan3[t3-1]-zhan3[t3];
                t3--;
            }
            else if(nibo[j]=='*')
            {
                zhan3[t3-1]=zhan3[t3-1]*zhan3[t3];
                t3--;
            }
            else if(nibo[j]=='/')
            {
                zhan3[t3-1]=zhan3[t3-1]/zhan3[t3];
                t3--;
            }
            else if(nibo[j]=='^')
            {
                zhan3[t3-1]=pow(zhan3[t3-1],zhan3[t3]);
                t3--;
            }
            else if(nibo[j]=='#')
            {
                zhan3[t3]=sqrt(zhan3[t3]);
            }
            j++;
            
        }
    string = [NSString stringWithFormat:@"%f",zhan3[t3]];
    textField.text=string;
    memset(str, 0, sizeof(str));
    count=0;
}

@end
