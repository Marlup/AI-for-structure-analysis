
function [q,yprima] = datatrain(h,b,L,E,den,ntraining)

k1=(5*L^4)/(384*E*((b*h^3)/12));
qm=den*b*h*10^-6;  %Own weight
ym=qm*k1;  %Deflection due to the own weight
%Training database as a function of the own weight and the distributed 
%loading q
    for i=1:1:ntraining
        q(i,1)=rand()*100; % I choose randomly the value of the distributed loading
        yprima(i,1)=q(i,1)*k1+ym;  %Deflection due to the own weight and distributed loading
    end 

end

%