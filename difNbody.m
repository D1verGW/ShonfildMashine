function difNbody
    
    % устанавливаем константы для задачи трех тел
    n = 4;
    mt = zeros(n,1);
    mt(1) = 1.98e+30;
    mt(2) = 5.97e+24;
    mt(3) = 6.93e+23;
    mt(4) = 1,8986e+27;
    g = 6.67408 * 10e-11;
    
    % задаем начальные координаты тел
    % начальные скорости задаем нулями
    
    d = zeros(6*n,1);
    % solar
    d(1) = 0;
    d(2) = 0;
    d(3) = 0;
    
    d(4) = -150000000;
    d(6) = -150000;
    
    d(7) = 225000000;
    
    d(10) = 778000000;
    
    d(17) = -3200.78*3600/4;
    d(20) = 2400.07*3600/4;
    d(23) = 1300.07*3600/4;
    function dv = dfunc(t,d)
        dv = zeros(6*n,1);
        for z=1:(3*n)
            dv(z) = d(3*n + z);
        end
        di = zeros(n);
        for q=1:n
                for j=(q+1):n
                    di(q,j) = (sqrt((d((q-1)*3+1) - d((j-1)*3+1))^2 + (d((q-1)*3+2) - d((j-1)*3+2))^2 + (d((q-1)*3+3) - d((j-1)*3+3))^2))^3;
                    di(j,q) = di(q,j);
                end
        end
        for i=1:n
            for j=1:n
                if j ~= i
                    dv(3*n + ((i-1)*3+1)) = dv(3*n + ((i-1)*3+1)) + g*mt(j)*((d((j-1)*3+1) - d((i-1)*3 + 1))/di(i,j)); %g*mt(2)*(d(4)-d(1))/r1r2 + g*mt(3)*(d(7)-d(1))/r1r3;
                    dv(3*n + ((i-1)*3+2)) = dv(3*n + ((i-1)*3+2)) + g*mt(j)*((d((j-1)*3+2) - d((i-1)*3 + 2))/di(i,j)); %g*mt(2)*(d(5)-d(2))/r1r2 + g*mt(3)*(d(8)-d(2))/r1r3;
                    dv(3*n + ((i-1)*3+3)) = dv(3*n + ((i-1)*3+3)) + g*mt(j)*((d((j-1)*3+3) - d((i-1)*3 + 3))/di(i,j)); %g*mt(2)*(d(6)-d(3))/r1r2 + g*mt(3)*(d(9)-d(3))/r1r3;
                end
            end
        end
    end
opt = odeset('RelTol',1e-1);
[T,Y] = ode45(@dfunc,[0:1:800],d,opt);
hold on;

for zz=1:n
    min_x(zz) = min(Y(:,(zz-1)*3+1));
    min_y(zz) = min(Y(:,(zz-1)*3+2));
    min_z(zz) = min(Y(:,(zz-1)*3+3));

    max_x(zz) = max(Y(:,(zz-1)*3+1));
    max_y(zz) = max(Y(:,(zz-1)*3+2));
    max_z(zz) = max(Y(:,(zz-1)*3+3));
end

minx=min(min_x);
miny=min(min_y);
minz=min(min_z);

maxx=max(max_x)+1e-9;
maxy=max(max_y)+1e-9;
maxz=max(max_z)+1e-9;


axis( [minx maxx miny maxy minz maxz+1e-9]);  
grid on;
    for k=1:size(T,1)
        cla;
        for kk=1:n
            plot3(Y(k,((kk-1)*3+1)),Y(k,((kk-1)*3+2)),Y(k,((kk-1)*3+3)),'*');
        end
        pause(0.0001);
        title(num2str(k));
    end
end


    