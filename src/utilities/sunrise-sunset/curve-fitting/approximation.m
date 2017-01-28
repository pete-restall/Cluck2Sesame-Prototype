function Y = approximation(x, p)
	phi = x / 366;
	phiA = p(3) + p(4) * phi;
	phiB = p(6) + p(7) * phi;
	phiC = p(9) + p(10) * phi;
	phiD = p(12) + p(13) * phi;
	a = p(2) * sin(2 * pi * phiA);
	b = p(5) * sin(2 * pi * phiB);
	c = p(8) * sin(2 * pi * phiC);
	d = p(11) * sin(2 * pi * phiD);
	Y = (p(1) + a + b + c + 0);
endfunction
