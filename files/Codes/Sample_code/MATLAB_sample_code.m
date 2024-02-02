% Roll Over SV model
%% parameters
r=0.01; r_bar = 0.03; KQ = 1;
v=0.04; v_bar = 0.04; K=1000;
V0=100.0; sigma_r=0.4; sigma_v=0;
rho_r = 0.2; rho_v =0; rho_rv=0;
T = 1.0; F0 = 100.0;

% Alpha
alpha = 0.5;

%% Zero-coupon bond price
syms y(t)
b = 1/KQ*(1-exp(-KQ*t)); %Note that here t actually is tau, i.e. T-t.

% ODE govern h
ode_h = odeToVectorField(-diff(y, t) == K*y+1/2*sigma_v^2*y^2+1/2*sigma_r^2*b^2+rho_rv*sigma_r*sigma_v*b*y);
M_h = matlabFunction(ode_h, 'vars', {'t', 'Y'});
sol_h = ode45(M_h, [0,T], 0);
h_zcb = @(x) deval(sol_h, x);

% Calculate a(t,T)
a = @(x) KQ*r_bar*int(b, 0 ,x) + K*v_bar*integral(@(y) deval(sol_h, y), 0, x);
b = matlabFunction(b);
zcb_T = double(exp(-a(T)-b(T)*r-h_zcb(T)*v));
%% Under measure S
f1 = @(phi) cf1(phi, r, r_bar, v, v_bar, KQ, K, V0, sigma_r, sigma_v, rho_r,rho_v,rho_rv,T);
p1 = 1/2+1/pi*quadv(@(phi) real(exp(-1i*phi*log(F0))*f1(phi)/(1i*phi)),0,100);
%% Under T-forward measure F
f2 = @(phi) cf2(phi, r, r_bar, v, v_bar, KQ, K, V0, sigma_r, sigma_v, rho_r,rho_v,rho_rv,T);
p2 = 1/2+1/pi*quadv(@(phi) real(exp(-1i*phi*log(F0))*f2(phi)/(1i*phi)),0,100);

%% Option Price
option_price = V0*p1-F0*zcb_T*p2;





%% Characterstic Function
function f = cf1(phi, r, r_bar, v, v_bar, KQ, K, V0, sigma_r, sigma_v, rho_r,rho_v,rho_rv, T)
X = log(V0);
C = @(x) 1/KQ*(1-exp(-KQ*x))*1i*phi;
% We have to solve D and h simultaneously. Since ode45 cannot give us
% function output
options = odeset('RelTol',1e-8,'AbsTol',1e-10);
sol = ode45(@(t,y) myode_1(t, y, phi, r, r_bar, v, v_bar, KQ, K, V0, sigma_r, sigma_v, rho_r,rho_v,rho_rv),[0,T], 0, options);
D = @(x) deval(sol, x);
A = KQ*r_bar*integral(@(tau) C(tau),0,T) + K*v_bar*integral(@(tau) D(tau), 0, T);
D_T = D(T);
C_T = C(T);
f = exp(A+C_T*r+D_T*v+1i*phi*X);
end

function dydt = myode_1(t, y, phi, r, r_bar, v, v_bar, KQ, K, V0, sigma_r, sigma_v, rho_r,rho_v,rho_rv)
C = 1/KQ*(1-exp(-KQ*t))*1i*phi;
dydt = 1/2*1i*phi-1/2*phi.^2+rho_r*sigma_r*C+1/2*sigma_r^2*C^2+(rho_v*sigma_v-K)*y+1/2*sigma_v^2*y.^2+...
    +rho_r*sigma_r*1i*phi*C+rho_v*sigma_v*1i*phi*y+rho_rv*sigma_r*sigma_v*C*y;
end


function f = cf2(phi, r, r_bar, v, v_bar, KQ, K, V0, sigma_r, sigma_v, rho_r,rho_v,rho_rv,T)
X = log(V0);
C = @(x) 1/KQ*(1-exp(-KQ*x))*1i*phi;
% We have to solve D and h simultaneously. Since ode45 cannot give us
% function output
b = @(x) 1/KQ*(1-exp(-KQ*x)); %Note that here t actually is tau, i.e. T-t.
options = odeset('RelTol',1e-8,'AbsTol',1e-10);
sol = ode45(@(t,y) myode_2(t, y, phi, r, r_bar, v, v_bar, KQ, K, V0, sigma_r, sigma_v, rho_r,rho_v,rho_rv),[0,T], [0 0], options);
D = @(x) deval(sol, x, 2);
A = KQ*r_bar*integral(@(tau) C(tau),0,T) + K*v_bar*integral(@(tau) D(tau), 0, T);
D_T = D(T); C_T = C(T);
f = exp(A+C_T*r+D_T*v+1i*phi*X);
end

function dydt = myode_2(t, y, phi, r, r_bar, v, v_bar, KQ, K, V0, sigma_r, sigma_v, rho_r,rho_v,rho_rv)
b = 1/KQ*(1-exp(-KQ*t));
C = 1/KQ*(1-exp(-KQ*t))*1i*phi;
dydt = zeros(2,1);
dydt(1) = -(K*y(1)+1/2*sigma_v^2*y(1)^2+1/2*sigma_r^2*b^2+rho_rv*sigma_r*sigma_v*b*y(1));
dydt(2) = (b*rho_r*sigma_r + rho_v*y(1)*sigma_v-1/2)*1i*phi-...
    1/2*phi.^2+(b*sigma_r^2+y(1)*rho_rv*sigma_r*sigma_v)*C+1/2*sigma_r^2*C.^2+...
    (rho_rv*sigma_r*sigma_v*b+sigma_v^2*y(1)-K)*y(2)+1/2*sigma_v^2*y(2)^2+...
    rho_r*sigma_r*1i*phi.*C+rho_v*sigma_v*1i*phi*y(2)+rho_rv*sigma_r*sigma_v*C*y(2);
end

