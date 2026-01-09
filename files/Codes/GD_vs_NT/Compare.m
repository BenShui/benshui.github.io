clear all;
clc;
lx = linspace(-20,20,100);
ly = linspace(-20,20,100);
[X,Y] = meshgrid(lx,ly);
Z = (10*X.^2+Y.^2)/2+5*log(1+exp(-X-Y));
contour(X,Y,Z);
hold on
eta = 0.05; %learning rate
%-----------------------------------------------------------------
%Gradient descent
tic
ep = 1e-5;
n_gd = 0;
x = 20;
y = 20;
e_gd = 1;
gd_x = [x];
gd_y = [y];
while e_gd>ep
    tmp_x = x - eta*(10*x-5*exp(-x-y)/(1+exp(-x-y)));
    tmp_y = y - eta*(y-5*exp(-x-y)/(1+exp(-x-y)));
    e_gd = sqrt((10*x-5*exp(-x-y)/(1+exp(-x-y)))^2+(y-5*exp(-x-y)/(1+exp(-x-y)))^2);
    x = tmp_x;
    y = tmp_y;
    gd_x = [gd_x,x];
    gd_y = [gd_y,y];
    n_gd = n_gd+1;
end
n_gd,e_gd
plot(gd_x,gd_y,'k-o');
hold on
toc
%------------------------------------------------------------------
% Newton's Method
tic
step = 0.5
ep = 1e-5;
n_nt = 0;
x = 20;
y = 20;
e_nt = 1;
nt_x = [x];
nt_y = [y];
while e_nt>ep
    a = 10+5*exp(-x-y)/(1+exp(-x-y))^2;
    b = 5*exp(-x-y)/(1+exp(-x-y))^2;
    c = 1+5*exp(-x-y)/(1+exp(-x-y))^2;
    Hx = [a,b;b,c];
    H_1 = inv(Hx);
    z = step * H_1 * [10*x-5*exp(-x-y)/(1+exp(-x-y));y-5*exp(-x-y)/(1+exp(-x-y))];
    tmp_x = x - z(1);
    tmp_y = y - z(2);
    e_nt = sqrt((y-5*exp(-x-y)/(1+exp(-x-y)))^2+(y-5*exp(-x-y)/(1+exp(-x-y)))^2);
    x = tmp_x;
    y = tmp_y;
    nt_x = [nt_x,x];
    nt_y = [nt_y,y];
    n_nt = n_nt+1;
end
n_nt,e_nt
plot(nt_x,nt_y,'b-o');
toc
