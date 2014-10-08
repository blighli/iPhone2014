#This is a simple makefile file~
.PHONY: cal
objects = main.m WeekDay.m DrawPic.m
cal : $(objects)
	gcc -o cal $(objects) -framework Foundation
WeekDay.m : WeekDay.h
DrawPic.m : DrawPic.h
	