function [price, lattice] = LatticeEurCall(S0,K,r,T,sigma,N)
deltaT = T/N;
u=exp(sigma * sqrt(deltaT));
d=1/u;
p=(exp(r*deltaT) - d)/(u-d);
lattice = zeros(N+1,N+1);
for i=0:N
   lattice(i+1,N+1)=max(0 , S0*(u^i)*(d^(N-i)) - K);
end
for j=N-1:-1:0
   for i=0:j
      lattice(i+1,j+1) = exp(-r*deltaT) * ...
         (p * lattice(i+2,j+2) + (1-p) * lattice(i+1,j+2));
   end
end
price = lattice(1,1);

