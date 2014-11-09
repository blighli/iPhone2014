cal : PrintGregorianCal.m main.m
	clang -fno-objc-arc -framework foundation PrintGregorianCal.m main.m -o cal

test :
	./cal
	./cal 10 2014
	./cal -m 10
	./cal 2014
	./cal s 5 a s
	./cal abc
	./cal 1
	./cal -m 13

clean :
	rm cal