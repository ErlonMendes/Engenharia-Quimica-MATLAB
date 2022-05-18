clear
clc

nx = 200;
ny = 200;
x = linspace(-2*pi,2*pi,nx);
y = linspace(-2*pi,2*pi,ny);

for i = 1:nx
    for j = 1:ny
        z(i,j) = sin(x(i))+sin(y(j));
    end
end

figure
surf(y,x,z,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
