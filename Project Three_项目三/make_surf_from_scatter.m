%% Making Surface Plots From Scatter Data
% How do you turn a collection of XYZ triplets into a surface plot? This is
% the most frequently asked 3D plotting question that I got when I was in
% Tech Support.

%% Load the data

% load seamount
% who -file seamount

%%
% The problem is that the data is made up of individual (x,y,z)
% measurements. It isn't laid out on a rectilinear grid, which is what the
% SURF command expects. A simple plot command isn't very useful.

% scatter3(S_X,T_t,bs_c_X,'fill','r');hold on;

% % Fig 4
% scatter3(S_X,T_t,bs_c_X,'fill','b');hold on;
% x= S_X;
% y= T_t;
% z = bs_c_X;
% 
% % Fig 5 (a)
x= rbf_S_X;
y= rbf_T_t;
% z= rbf_c;
% scatter3(x,y,z,'fill','r');hold on;


% Fig 5(b)
% z= rbf_delta;
% scatter3(x,y,z,'fill','r');hold on;

% % Fig 5(c)
% z= price_error;
% [row col] = size(z);
% % [row col] = max(z);
% % % max= 0.038, ind = 151
% % z(151,:)=0;
% % z(101,:)=0;
% for i = 1:1:row
%     if z(i,:)> 0.02
%         z(i,:)=0;
%     end
% end
% 
% 
% scatter3(x,y,z,'fill','g');hold on;

% Fig 5 (d)
z= delta_error;
scatter3(x,y,z,'fill','r');hold on;

%
plot3(x,y,z,'.')

%% Little triangles
% The solution is to use Delaunay triangulation. Let's look at some
% info about the "tri" variable.

tri = delaunay(x,y);
plot(x,y,'.')

%%
% How many triangles are there?

[r,c] = size(tri);
disp(r)

%% Plot it with TRISURF

h = trisurf(tri, x, y, z);
% axis vis3d

%% Clean it up

% axis off
% l = light('Position',[-50 -15 29])
% set(gca,'CameraPosition',[208 -50 7687])
lighting phong
shading interp
% colorbar EastOutside

% % Fig 4
% title('Simulated call price from Black-Scholes','FontSize', 14)
% xlabel('S/X','FontSize', 14)
% ylabel('T-t','FontSize', 14)
% zlabel('C/X','FontSize', 14)
%

% % Fig 5 (a)
% title('RBF network call price','FontSize', 14)
% xlabel('S/X','FontSize', 14)
% ylabel('T-t','FontSize', 14)
% zlabel('estimated C/X','FontSize', 14)

% % Fig 5(b)
% xlabel('S/X','FontSize', 14)
% ylabel('T-t','FontSize', 14)
% zlabel('network delta','FontSize', 14)
% title('RBF network delta','FontSize', 14)
% %

% % Fig 5 (c)
% title('Call price error','FontSize', 14)
% xlabel('S/X','FontSize', 14)
% ylabel('T-t','FontSize', 14)
% zlabel('C/X error','FontSize', 14)

% Fig 5 (d)
xlabel('S/X','FontSize', 14)
ylabel('T-t','FontSize', 14)
zlabel('delta error','FontSize', 14)
title('Delta error','FontSize', 14)
