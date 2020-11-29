function H = rgb2h(x)
    r = x(1);
    g = x(2);
    b = x(3);
    num = 0.5*((r - g) + (r - b));
    den = sqrt((r - g).^2 + (r - b).*(g - b));
    theta = acos(num./(den + eps));
    H = theta;
    H(b > g) = 2*pi - H(b > g);
    H = H/(2*pi);
    D = H * 360;
    D(D>180) = D(D>180) -360; 
end