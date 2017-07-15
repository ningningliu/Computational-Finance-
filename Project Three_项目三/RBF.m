% Load data 
filename = 'c2925.prn';
dt_c1 = importdata(filename);
% plot(dt_c1(:,3))
% % 

% Compute C/X, T-t, S/X
X= 2925;
normalise_dt = zeros(222,3);
normalise_dt (:,3)= dt_c1(:,3)/X;
normalise_dt(:,2) = dt_c1(:,2)/X;
for i = 1:1:222
    normalise_dt(i,1)= (222-i)/253;
end

T_t = normalise_dt(:,1);
S_X = normalise_dt(:,3);
C_X = normalise_dt(:,2);
x= S_X;
y= T_t;
z= C_X;
scatter3(S_X,T_t,C_X); hold on
% plot3(x,y,z,'.-')
% 
% % Little triangles
% % The solution is to use Delaunay triangulation. Let's look at some
% % info about the "tri" variable.
% 
% tri = delaunay(x,y);
% plot(x,y,'.')
% 
% %
% % How many triangles are there?
% 
% [r,c] = size(tri);
% disp(r)
% 
% % Plot it with TRISURF
% 
% h = trisurf(tri, x, y, z);
% axis vis3d
% 
% % Clean it up
% 
% % axis off
% % l = light('Position',[-50 -15 29])
% % set(gca,'CameraPosition',[208 -50 7687])
% lighting phong
% % shading interp
% % colorbar EastOutside

% [X, Y,Z]= meshgrid(T_t, S_X,C_X);
% mesh(X,Y,Z);
% grid= meshgrid(S_X, T_t);
% Z= [grid C_X];
% 
% scatter3(T_t,S_X,C_X); hold on
% Z =[T_t S_X C_X];
% mesh(Z)
% set(gca, 'XDir', 'reverse')
xlabel('S/X')
ylabel('T-t')
zlabel('C/X')
% 

%  surf (T_t, S_X,C_X)


% % Compute RBF 
% vector x
% x= [S_X T_t]';

% GMModel = fitgmdist(x',4)
% mu= GMModel.mu;
% cov= GMModel.Sigma;

% % use gmdistribution
% options = statset('Display','final');
% obj = gmdistribution.fit(x',4,'Options',options);
% ComponentMeans = obj.mu
% ComponentCovariances = obj.Sigma

% Construct design matrix
% A = ones(222,7);
% for j = 1:1:4
%     for i=1:1:222
%         A(i,j)= (x(:,i)-mu(j,:)')'*cov(:,:,j)*(x(:,i)-mu(j,:)');
%     end
% end

% A(:,5)= S_X;
% A(:,6)= T_t;

% Etimate weights by least square 
% w = A\C_X;

% bldelta
        
        
