//
//  main.m
//  cal_command
//
//  Created by xufei on 14-10-9.
//  Copyright (c) 2014年 xufei. All rights reserved.
//

#import <Foundation/Foundation.h>

char  *c_month[12]={" 一月"," 二月"," 三月"," 四月"," 五月"," 六月"," 七月"," 八月"," 九月"," 十月","十一月","十二月"};



int get_week(int year,int month,int day)
{//蔡勒公式计算某年某月某日对应周几，返回对应整数，新期日标为0，依次类推1，2，3，4，5，6
		if(month==1||month==2)//判断month是否为1或2
		{
			year--;
			month+=12;
		}
		int c=year/100;
		int y=year-c*100;
		int week=(c/4)-2*c+(y+y/4)+(13*(month+1)/5)+day-1;
		while(week<0){week+=7;}
		    week%=7;
	return week;
}



void print_current_month(int year,int month,int  month_days,int week_what)
{
	printf("    %s %d       \n",c_month[month-1],year);
	printf("日 一 二 三 四 五 六\n");
	int n=1;
	week_what%=7;
	for(int i=0;i<7;++i){
		if(i==week_what){
		    printf("%2d",n++);
		    break;
		}
		else{
		    printf("   ");
		}
	}
	
	while(n<=month_days){
	    week_what=(week_what+1)%7;
		if(!week_what){
			printf("\n%2d",n++);
		}else{
		    printf(" %2d",n++);
		}
	}
	printf("\n");
}


int is_num(const char *src)
{
	int flag=1;
	for(int i=0;i<strlen(src);++i){
		if(!isalnum(src[i])) {
			flag=0;
			break;
		}
	}
	return flag;
}

int is_leap_year(int year)
{//是否闰年
	
    return (year%4==0 && year%100!=0) || (year%400==0);
}

int is_right_year(int year)
{
    return year>=1 && year<=9999;
}

int is_right_month(int month)
{
    return month>=1 && month<=12;
}

void error_year(int year)
{
    printf("%d not in range 1..9999\n",year);
	exit(0);
}

void error_month(int month)
{
    printf("%d not in range 1..12\n",month);
	exit(0);
}

int main(int argc, const char * argv[])
{
	int each_month_days[12]={31,29,31,30,31,30,31,31,30,31,30,31};

	
	NSDate * newDate = [NSDate date];
	
	NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
	
    [dateformat setDateFormat:@"yyyy MM"];
	
    NSString * newDateOne = [dateformat stringFromDate:newDate];
	
    [dateformat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	
	const char *buf;
	buf=[newDateOne UTF8String];
   
	if(argc>=2 && argc<=4){
		if(strcmp(argv[1],"cal")!=0 && strcmp(argv[1], "CAL")!=0){
			printf("%s command not found\n",argv[1]);
			exit(0);
		}
	}
	if(argc==2){//处理cal指令
		int year,month,day=1;
		sscanf(buf,"%d%d",&year,&month);
		if(is_leap_year(year)){
		    each_month_days[1]=28;
		}
		int week=get_week(year, month, day);
		print_current_month(year,month,each_month_days[month-1],week);
	}
	else if(argc==3){//处理cal 2014命令
		int tfy=is_num(argv[2]);
		if( tfy){//处理cal 10 2014
			int year,day=1;
			sscanf(argv[2],"%d",&year);
			if(!is_right_year(year)){
				error_year(year);
			}
			if(is_leap_year(year)){
				each_month_days[1]=28;
			}
			for(int i=1;i<=12;++i){
				int week=get_week(year, i, day);
				print_current_month(year,i,each_month_days[i-1],week);
			}
		}else{
			printf("-haha:%s command not find",argv[2]);
		}
		
	}
	else if(argc==4){
	    if(strcmp(argv[2],"-m")==0 || strcmp(argv[2], "-M") ==0){//处理cal -m 10
			int tfm=is_num(argv[3]);
			if(tfm){
			    int year,month,day=1;
				sscanf(buf,"%d",&year);
				sscanf(argv[3],"%d",&month);
				
				if(!is_right_month(month)){
					error_month(month);
				}
				
				if(is_leap_year(year)){
					each_month_days[1]=28;
				}
				
				int week=get_week(year, month, day);
				print_current_month(year,month,each_month_days[month-1],week);
				
			}else{
		    	printf("-haha:%s command not find",argv[3]);
			}
		}else{
			int tfm=is_num(argv[2]);
			int tfy=is_num(argv[3]);
			if(tfm && tfy){//处理cal 10 2014
			    int month,year,day=1;
				sscanf(argv[2],"%d",&month);
				sscanf(argv[3],"%d",&year);
				
				if(!is_right_year(year)){
					error_year(year);
				}
				if(!is_right_month(month)){
					error_month(month);
				}
				
				if(is_leap_year(year)){
					each_month_days[1]=28;
				}
				int week=get_week(year, month, day);
				print_current_month(year,month,each_month_days[month-1],week);
			}else{
			    printf("-haha:%s command not find",argv[2]);
			}
		}
	}
    //printf("%d is neither a month number (1..12) nor a name\n",param_value);
	return 0;
}

