//
//  main.m
//  Steve
//
//  Created by qtsh on 14-10-12.
//  Copyright (c) 2014年 Steve. All rights reserved.
//


#import <Foundation/Foundation.h>

/********
 功能：打印日历
 输入：yorm:1:year  0:month
 year:year
 month:month
 输出：
 ********/
int whatday(int year,int month)
{
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:1];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [weekdayComponents weekday];
    return weekday;
    return 1;
}
int howmanydays(int month,int year)
{
    if(month==2)
    {
        if(year%4==0&&year%100!=0)
            return 29;
        else if(year%400==0) return 29;
        else return 28;
    }
    else if(month==4||month==6||month==9||month==11) return 30;
    else return 31;
}
void printMonth(int weekday,int year,int month)
{
    switch (month) {
        case 1:
            printf("     一 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 2:
            printf("     二 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 3:
            printf("     三 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 4:
            printf("     四 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 5:
            printf("     五 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 6:
            printf("     六 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 7:
            printf("     七 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 8:
            printf("     八 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 9:
            printf("     九 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 10:
            printf("     十 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 11:
            printf("     十一 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        case 12:
            printf("     十二 月 %d\n日 一 二 三 四 五 六\n",year);
            break;
        default:
            break;
    }
    for(int i=1;i<weekday;i++) printf("   ");
    int days=howmanydays(month, year);
    for(int i=1;i<days;i++)
    {
        printf("%2d ",i);
        weekday++;
        if(weekday==8) {printf("\n");weekday=1;}
        
    }
    printf("%d\n",days);
    
}
void printCalendar(int yorm,long year ,long month)
{
    int weekday;
    if(yorm == 1)
    {
        for(int i=1;i<=12;i++){
            weekday=whatday(year,i);
            printMonth(weekday,year,i);
        }}
    else
    {
        weekday=whatday(year,month);
        printMonth(weekday,year,month);
    }
    
}
/********
 功能：判断字符串是否都是数字
 输入：input：输入字符串
 输出：1:是 0：否
 ********/
int isNumeric(const char * input)
{
    long len = strlen(input);
    int i;
    for(i=0; i<len; i++)
    {
        if( i==0 && input[i] != '+' && input[i] != '-' && (input[i]<'0' || input[i] >'9'))
        {
            return 0;
        }
        else if(input[i]<'0' || input[i] >'9')
        {
            return 0;
        }
    }
    return 1;
}
int main(int argc, const char * argv[]);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSDateFormatter *nsdf= [NSDateFormatter new];
        [nsdf setDateStyle:NSDateFormatterShortStyle];
        [nsdf setDateFormat:@"YYYY"];
        NSString *nsstrYear =[nsdf stringFromDate:[NSDate date]];
        long curY=[nsstrYear longLongValue];
        NSDateFormatter *nsdf2= [NSDateFormatter new];
        [nsdf2 setDateStyle:NSDateFormatterShortStyle];
        [nsdf2 setDateFormat:@"MM"];
        NSString *nsstrMonth =[nsdf2 stringFromDate:[NSDate date]];
        long curM=[nsstrMonth longLongValue];
        
        int tmp,tmp2;
        if( 3<argc)
        {
            NSLog(@"Invalid Input!\n");
            return 0;
        }
        /**********     1 args  *********/
        else if(argc == 1)
        {
            //NSLog(@"输出今年本月的月历");
            printCalendar(0, curY, curM);
        }
        /**********     2 args  *********/
        else if(argc == 2)
        {
            tmp = atoi(argv[1]);
            if( !isNumeric(argv[1]) )
            {
                NSLog(@"Invalid input");
                return 0;
            }
            if( strlen(argv[1])>5 )
            {
                NSLog(@"The year is too long");
                return 0;
            }
            else
            {
                //NSLog(@"输出%d整年的月历",tmp);
                printCalendar(1,tmp,1);
                
            }
        }
        /***********  2 args end **********/
        /************    3 args  ************/
        else
        {
            /**** like cal -m 10 *****/
            if( 0 == strcmp(argv[1],"-m"))
            {
                if( isNumeric(argv[2]))
                {
                    tmp = atoi(argv[2]);
                    if( 0>tmp || 12<tmp)
                    {NSLog(@"Invalid Input!\n");
                        return 0;}
                    else
                        //NSLog(@"输出今年%d月的月历",tmp);
                        printCalendar(0,curY,tmp);
                }
                else
                {
                    NSLog(@"Invalid Input!\n");
                    return 0;
                }
            }
            /**** like cal 10 2014 ****/
            else if( isNumeric(argv[1]))
            {
                tmp = atoi(argv[1]);
                if( 0>tmp || 12<tmp)
                {NSLog(@"Invalid Input!\n");
                    return 0;}
                else
                {
                    if(isNumeric(argv[2]))
                    {
                        tmp2 = atoi(argv[2]);
                        {
                            if( tmp2>9999)
                            {
                                NSLog(@"year too long");
                                return 0;
                            }
                            //NSLog(@"输出%d年%d月的月历",tmp2,tmp);
                            printCalendar(0,tmp2,tmp);
                        }
                    }
                    else
                    {
                        NSLog(@"Invalid Input!\n");
                        return 0;
                    }
                }
            }
            /********* 3 args end ************/
            /********* args number error ******/
            else
            {
                NSLog(@"Invalid Input!\n");
                return 0;
            }
            /******** args number error end ******/
        }
        
        
    }
    
    return 0;
}

