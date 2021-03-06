G1 = 1/1;
G2 = 1/2;
G3 = 1/10;
G4 = 1/0.1;
Go = 1/1000;

alpha = 100;
L = 0.2;
C = 0.25 + 0.05.*rand(1,1);
Vin = 0;
Cm = [0 -C C 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 L 0 0; 0 0 0 0 -L 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0];
Gm = [1 -G1 G1 0 0 0 0; 0 1 0 0 0 0 0; 1 0 -G2-G3 0 G3 0 0; 0 0 1 1 1 0 0; 0 0 0 G3 1 0 0; 0 0 0 0 alpha 1 0; 0 0 0 0 0 -G4 G4+Go];

F = [0 Vin 0 0 0 alpha*G3 0]';

Vout = zeros(21, 1);
V3 = zeros(21, 1);
x = linspace(-10, 10, 21);


for i = 1 : 21
    Vin = x(i);
    Cm = [0 -C C 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 L 0 0; 0 0 0 0 -L 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0];
    Gm = [1 -G1 G1 0 0 0 0; 0 1 0 0 0 0 0; 1 0 -G2-G3 0 G3 0 0; 0 0 1 1 1 0 0; 0 0 0 G3 1 0 0; 0 0 0 0 alpha 1 0; 0 0 0 0 0 -G4 G4+Go];
    F = [0 Vin 0 0 0 alpha*G3 0]'; 
    a = Gm\F;
    Vout(i, 1) = a(5); 
    V3(i, 1) = a(3); 
end

figure(1)
plot(x, Vout)
hold on
plot(x, V3)
w = linspace(1, 100, 100);
capacitances = zeros(100,1);
Vin = 1;
Vout2 = zeros(100,1);
for j = 1: 100
    C = 0.25 + 0.05.*rand(1,1);
    Cm = [0 -C C 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 L 0 0; 0 0 0 0 -L 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0];
    Gm = [1 -G1 G1 0 0 0 0; 0 1 0 0 0 0 0; 1 0 -G2-G3 0 G3 0 0; 0 0 1 1 1 0 0; 0 0 0 G3 1 0 0; 0 0 0 0 alpha 1 0; 0 0 0 0 0 -G4 G4+Go];
    F = [0 Vin 0 0 0 alpha*G3 0]';
    img = w(i) * 1i;
    a = (Gm + Cm*img)\F;
    Vout2(i, 1) = a(5); 
    capacitances(i) = C;
end

g = 20*log(Vout2./Vin);

figure(2)
histogram(abs(g))

figure(3)
histogram(capacitances)

