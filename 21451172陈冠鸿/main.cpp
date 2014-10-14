#pragma warning(disable:4996)
#include "calendar.h"

int main(int argc, char **argv)
{
	struct tm *local_time;
	const time_t now = time(NULL);
	local_time = localtime(&now);
	int year = local_time->tm_year + 1900;
	int month = local_time->tm_mon + 1;
	switch (argc)
	{
	case 1:
		//cal:输出本机时间月历
		show_cal(month, year);
		break;
	case 2:
		//cal year :输出当年月历
		year = atoi(*(argv+1));
		if (year < 1900)
			printf("illegal year:use 1900-9999\n"); 
		else
		{
			for (month = 1; month <= 12;++month)
				show_cal(month, year);
		}
		break;
	case 3:
		//cal -m month: ...
		if (strcmp(*(argv + 1), "-m") == 0)
		{
			month = atoi(*(argv + 2));
			if (month > 12 || month < 1)
				printf("illegal month:use 1-12\n");
			else
				show_cal(month, year);
		}
		//cal month year: ....
		else if (atoi(*(argv + 1)) <= 12 && atoi(*(argv + 1)) >= 1 && atoi(*(argv + 2)) >= 1900)
		{
			month = atoi(*(argv + 1));
			year = atoi(*(argv + 2));
			show_cal(month, year);
		}
		else
			printf("illegal input!\n");
		break;
	default:
		break;
	}
	return 0;
}
