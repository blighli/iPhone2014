#This is a simple makefile~
.PHONY: cal
objects = main.m WeekDay.m DrawPic.m
cal : $(objects)
	gcc -o cal $(objects) -framework Foundation
WeekDay.m : WeekDay.h
DrawPic.m : DrawPic.h
run :
	./cal
clean :
	rm cal