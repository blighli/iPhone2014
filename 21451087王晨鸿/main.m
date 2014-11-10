//
//  main.m
//  Cal
//
//  Created by 王晨鸿 on 14-10-10.
//  Copyright (c) 2014年 qtsh. All rights reserved.
//

#import <Foundation/Foundation.h>
char strYear[13][500];

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
void getmonth(int year,int month)
{
   
    int weekday=whatday(year, month);
    switch (month) {
        case 1:
            //[ms appendString:(NSString \n)@"        一 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[1],"        一 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 2:
            //[ms appendString:(NSString *)@"        二 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[2],"        二 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 3:
            //[ms appendString:(NSString *)@"        三 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[3],"        三 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 4:
            //[ms appendString:(NSString *)@"        四 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[4],"        四 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 5:
            //[ms appendString:(NSString *)@"        五 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[5],"        五 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 6:
            //[ms appendString:(NSString *)@"        六 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[6],"        六 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 7:
            //[ms appendString:(NSString *)@"        七 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[7],"        七 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 8:
            //[ms appendString:(NSString *)@"        八 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[8],"        八 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 9:
            //[ms appendString:(NSString *)@"        九 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[9],"        九 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 10:
            //[ms appendString:(NSString *)@"        十 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[10],"        十 月       \n日 一 二 三 四 五 六 \n");
            break;
        case 11:
            //[ms appendString:(NSString *)@"        十一 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[11],"        十一 月     \n日 一 二 三 四 五 六 \n");
            break;
        case 12:
            //[ms appendString:(NSString *)@"        十二 月*日 一 二 三 四 五 六*"];
            sprintf(strYear[12],"        十二 月     \n日 一 二 三 四 五 六 \n");
            break;
        default:
            break;
    }
    for(int i=1;i<weekday;i++)
        strcat(strYear[month],"   ");//[ms appendString:(NSString *)@"   "];
    //printf("%s",strYear[month]);////////////////
    int days=howmanydays(month, year);
    for(int i=1;i<days;i++)
    {
        char tmpstr[50];
        memset(tmpstr, 0, 50);
        sprintf(tmpstr,"%2d ",i);
        strcat(strYear[month],tmpstr);
        weekday++;
        if(weekday==8) {/*[ms appendString:(NSString *)@"*"]*/strcat(strYear[month],"\n");weekday=1;}
        
    }
//    NSString *tmpstr=[NSString stringWithFormat:@"%d",days];
//    [ms appendString:(NSString *)tmpstr];
//    [ms appendString:(NSString *)@"*"];
    char tmpstr[50];
    memset(tmpstr, 0, 50);
    sprintf(tmpstr, "%d ",days);
    strcat(strYear[month], tmpstr);
    strcat(strYear[month], "\n");
    //printf("%s",strYear[month]);////////////////
}
void printYear()
{
    char strMontha[8][50];
    char strMonthb[8][50];
    char strMonthc[8][50];
    printf("\n");
        for( int i =0; i <8; i++)
        {
            memset(strMontha[i], 0, 50);
            memset(strMonthb[i], 0, 50);
            memset(strMonthc[i], 0, 50);
        }
        sscanf(strYear[1],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMontha[0],strMontha[1],strMontha[2],strMontha[3],strMontha[4],strMontha[5],strMontha[6],strMontha[7]);
    //printf("test%s",strMontha[1]);///////////////////
        sscanf(strYear[2],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMonthb[0],strMonthb[1],strMonthb[2],strMonthb[3],strMonthb[4],strMonthb[5],strMonthb[6],strMonthb[7]);
        sscanf(strYear[3],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMonthc[0],strMonthc[1],strMonthc[2],strMonthc[3],strMonthc[4],strMonthc[5],strMonthc[6],strMonthc[7]);
    
        for( int i=0 ;i<8 ;i++)
        {
            if( i<=5)
            printf("%21s  %21s  %21s  \n",strMontha[i],strMonthb[i],strMonthc[i]);
            else
            printf("%-21s  %-21s  %-21s  \n",strMontha[i],strMonthb[i],strMonthc[i]);
        }
    
    for( int i =0; i <8; i++)
    {
        memset(strMontha[i], 0, 50);
        memset(strMonthb[i], 0, 50);
        memset(strMonthc[i], 0, 50);
    }
    sscanf(strYear[4],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMontha[0],strMontha[1],strMontha[2],strMontha[3],strMontha[4],strMontha[5],strMontha[6],strMontha[7]);
    //printf("test%s",strMontha[1]);///////////////////
    sscanf(strYear[5],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMonthb[0],strMonthb[1],strMonthb[2],strMonthb[3],strMonthb[4],strMonthb[5],strMonthb[6],strMonthb[7]);
    sscanf(strYear[6],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMonthc[0],strMonthc[1],strMonthc[2],strMonthc[3],strMonthc[4],strMonthc[5],strMonthc[6],strMonthc[7]);
    
    for( int i=0 ;i<8 ;i++)
    {
        if( i<=5)
            printf("%21s  %21s  %21s  \n",strMontha[i],strMonthb[i],strMonthc[i]);
        else
            printf("%-21s  %-21s  %-21s  \n",strMontha[i],strMonthb[i],strMonthc[i]);
    }

    
    for( int i =0; i <8; i++)
    {
        memset(strMontha[i], 0, 50);
        memset(strMonthb[i], 0, 50);
        memset(strMonthc[i], 0, 50);
    }
    sscanf(strYear[7],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMontha[0],strMontha[1],strMontha[2],strMontha[3],strMontha[4],strMontha[5],strMontha[6],strMontha[7]);
    //printf("test%s",strMontha[1]);///////////////////
    sscanf(strYear[8],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMonthb[0],strMonthb[1],strMonthb[2],strMonthb[3],strMonthb[4],strMonthb[5],strMonthb[6],strMonthb[7]);
    sscanf(strYear[9],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMonthc[0],strMonthc[1],strMonthc[2],strMonthc[3],strMonthc[4],strMonthc[5],strMonthc[6],strMonthc[7]);
    
    for( int i=0 ;i<8 ;i++)
    {
        if( i<=5)
            printf("%21s  %21s  %21s  \n",strMontha[i],strMonthb[i],strMonthc[i]);
        else
            printf("%-21s  %-21s  %-21s  \n",strMontha[i],strMonthb[i],strMonthc[i]);
    }

    
    for( int i =0; i <8; i++)
    {
        memset(strMontha[i], 0, 50);
        memset(strMonthb[i], 0, 50);
        memset(strMonthc[i], 0, 50);
    }
    sscanf(strYear[10],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMontha[0],strMontha[1],strMontha[2],strMontha[3],strMontha[4],strMontha[5],strMontha[6],strMontha[7]);
    //printf("test%s",strMontha[1]);///////////////////
    sscanf(strYear[11],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMonthb[0],strMonthb[1],strMonthb[2],strMonthb[3],strMonthb[4],strMonthb[5],strMonthb[6],strMonthb[7]);
    sscanf(strYear[12],"%[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n] %[^\n]",strMonthc[0],strMonthc[1],strMonthc[2],strMonthc[3],strMonthc[4],strMonthc[5],strMonthc[6],strMonthc[7]);
    
    for( int i=0 ;i<8 ;i++)
    {
        if( i<=5)
            printf("%21s  %21s  %21s  \n",strMontha[i],strMonthb[i],strMonthc[i]);
        else
            printf("%-21s  %-21s  %-21s  \n",strMontha[i],strMonthb[i],strMonthc[i]);
    }


}
void printCalendar(int yorm,long year ,long month)
{
    int weekday;
    if(yorm == 1)
    {
        //NSMutableArray* monthlist=[NSMutableArray arrayWithCapacity:500];
        for(int i=1;i<=12;i++){
            getmonth(year,i);
            //monthlist[i]=ms;
            //NSLog(@"%@",monthlist[i]);
            
            }
        printf("                                %ld\n",year);
        printYear();
    }
    else
    {
        weekday=whatday(year,month);
        printMonth(weekday,year,month);
    }
    
}
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
        //ms=[NSMutableString stringWithCapacity:500];
        
        int tmp,tmp2;
        
        for(int i =0; i<13; i++)
        {
            memset(strYear[i], 0, 500);
        }
        if( 3<argc)
        {
            NSLog(@"请不要乱输入好么！\n");
            return 0;
        }
        else if(argc == 1)
        {
            printCalendar(0, curY, curM);
        }
        else if(argc == 2)
        {
            tmp = atoi(argv[1]);
            if( !isNumeric(argv[1]) )
            {
                NSLog(@"请不要乱输入好么！");
                return 0;
            }
            if( strlen(argv[1])>4 )
            {
                NSLog(@"year太长我算不出来好么！");
                return 0;
            }
            else
            {
                printCalendar(1,tmp,1);
                
            }
        }
        else
        {
            if( 0 == strcmp(argv[1],"-m"))
            {
                if( isNumeric(argv[2]))
                {
                    tmp = atoi(argv[2]);
                    if( 0>tmp || 12<tmp)
                    {NSLog(@"请不要乱输入好么!\n");
                        return 0;}
                    else
                        printCalendar(0,curY,tmp);
                }
                else
                {
                    NSLog(@"请不要乱输入好么!\n");
                    return 0;
                }
            }
            else if( isNumeric(argv[1]))
            {
                tmp = atoi(argv[1]);
                if( 0>tmp || 12<tmp)
                {NSLog(@"请不要乱输入好么!\n");
                    return 0;}
                else
                {
                    if(isNumeric(argv[2]))
                    {
                        tmp2 = atoi(argv[2]);
                        {
                            if( tmp2>9999)
                            {
                                NSLog(@"year太长我算不出来好么！");
                                return 0;
                            }
                            printCalendar(0,tmp2,tmp);
                        }
                    }
                    else
                    {
                        NSLog(@"请不要乱输入好么!\n");
                        return 0;
                    }
                }
            }
            else
            {
                NSLog(@"请不要乱输入好么!\n");
                return 0;
            }
        }
        
        
    }
    
    return 0;
}
