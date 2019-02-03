
%A=Features(1:30,:)
a = 1; b = 30;
x =unique(round( a + (b-a) * rand(10,1)))
%index = ceil(length(A) * rand(1,1)) 
index=ceil(length(A) * rand(1,100) )
plot(index)