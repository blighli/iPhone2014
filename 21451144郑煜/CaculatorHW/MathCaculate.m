//
//  MathCaculate.m
//  CaculatorHW
//
//  Created by StarJade on 14-11-9.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#include<string.h>
#include<stdlib.h>
#import "MathCaculate.h"
#define N 1000

@interface MathCaculate(){
    char infix[N];  //中缀表达式（未分离，都在一个字符串里）
    int expression[N][10]; //保存预处理过的表达式，也就是每个元素都分离过的表达式
    char suffix[N][10];     //保存后缀表达式的操作数
    int suffixLength;//后缀表达式的长度

}

- (int) level:(char)a;
- (int) isDigital:(char)x;
- (int) isNumber:(char *)str;

- (void) pretreatment:(char *)str;

- (void) infix_to_suffix;
- (void) getResult;

@end

@implementation MathCaculate

- (int) level:(char)a{
    switch(a){
        case '#':return 0;
        case '+':
        case '-':return 1;
        case '*':
        case '/':
        case 'm':return 2;
        default:break;
    }
    return -1;
}
- (int) isDigital:(char)x{
    if( (x>='0'&&x<='9') || (x>='A'&&x<='Z') || (x>='a'&&x<='z') || (x=='.') )
        return 1;
    return 0;

}
- (int) isNumber:(char *)str{
    int i;
    for(i=0;str[i];i++){
        int tag = [self isDigital:str[i]];
        if(tag == 0)return 0;
    }
    return 1;
}

- (void) pretreatment:(char *)str{
    int i,j,numberFlag;
    char temp[3];
    char number[10];
    int count=0;
    numberFlag=0;
    for(j=0,i=0;str[i];i++){
        int tag = [self isDigital:str[i]];
        if(tag == 0){
            if(numberFlag==1){
                number[j]=0;
                strcpy(expression[count++],number);
                j=0;
                numberFlag=0;
            }
            if(str[i]!=' '){
                temp[0]=str[i];temp[1]=0;
                strcpy(expression[count++],temp);
            }
        }
        else {
            numberFlag=1;
            number[j++]=str[i];
        }
    }
//    
//    puts("分离后的表达式为");
//    for(i=0;i<count;i++){
//        printf("%s ",expression[i]);
//    }puts("");
//    puts("");
    
}

- (void) infix_to_suffix{
    
    memset(suffix,0,sizeof(suffix));
    suffixLength=0;
    
    NSStack *st = [[NSStack alloc] init];
    int i=0;
    char Mark[2]="#";
    [st push:Mark];
    do{
        int num = [self isNumber:expression[i]];
        if(num ==1)//运算数直接保存到后缀表达式中
            strcpy(suffix[suffixLength++],expression[i]);
        else if(expression[i][0]=='(')        //是 左括号，直接入栈
            [st push:expression[i]];
        else if(expression[i][0]==')'){        //是 右括号，栈顶出栈，直到与其匹配的左括号出栈
            while( strcmp([st top],"(")!=0 ){
                char temp[10];
                strcpy(temp,[st top]);
                strcpy(suffix[suffixLength++],temp);
                [st pop];
            }
            [st pop];
        }
        else if( strcmp([st top],"(")==0 )//是 运算符，且栈顶是左括号，则该运算符直接入栈
            [st push:expression[i]];
        else {                    //是 运算符，且栈顶元素优先级不小于运算符，则栈顶元素一直
            //出栈，直到 栈空 或者 遇到一个优先级低于该运算符的元素
            while( ![st empty] ){
                char temp[10];
                strcpy(temp,[st top]);
                
                if( [self level:expression[i][0]] > [self level:temp[0]] )
                    break;
                strcpy(suffix[suffixLength++],temp);
                st.pop();
            }
            st.push(str[i]);
        }
        i++;
    }while(str[i][0]!=0);
    
    while( strcmp(st.top(),"#")!=0 ){        //将栈取空结束
        char temp[10];
        strcpy(temp,st.top());
        strcpy(suffix[suffixLength++],temp);
        st.pop();
    }
    
    puts("后缀表达式为：");
    for(i=0;i<suffixLength;i++){
        printf("%s",suffix[i]);
    }puts("");
    puts("");
}
- (void) getResult{
    
}

@end



@implementation NSStack

@synthesize count;

- (instancetype)init
{
    if( self=[super init] )
    {
        m_array = [[NSMutableArray alloc] init];
        count = 0;
    }
    return self;
}

- (void)push:(int *)anObject
{
    
    [m_array addObject:anObject];
    count = (int)m_array.count;
    
}
- (void)pop
{
    if(m_array.count > 0)
    {
        
        [m_array removeLastObject];
        count = (int)m_array.count;
    }
}
- (int)empty{
    [
    return 1;
}
- (char *)top{
    
    id obj = [m_array lastObject];
    return obj;
}

- (void)clear
{
    [m_array removeAllObjects];
    count = 0;
}

@end
