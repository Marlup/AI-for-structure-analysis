clear

%base de datos de vigas
%
E=30000; %N/mm2
b=300; %mm
h=600; %mm
L=10000; %mm
den=25; %N/mm3
ntraining=1000;

%Genero la base de datos de entrenamiento
[q,yprima] = datatrain(h,b,L,E,den,ntraining);
%Genero la base de datos de prueba
ntest=0.1*ntraining;
[qt,yprimat] = datatrain(h,b,L,E,den,ntest);

%inicializo los datos de w1 y b
w(1,1) = 10;
b(1) = 5;


%valores feten
% w(1,2) = 0.8;
% b(1) = 3.6;


%Entrenamiento de la red neuronal
rho=0.0001;%ratio de aprendizaje
niter=200;%numero de iteraciones en el aprendizaje
figure
%calculo la predicción
for i=1:1:niter
y= q*w+b;
% calculo el error medio para monitorizar mi predicción
error=(1/(2*ntraining))*sum((y-yprima).^2);
plot(i,error,'-ok')
hold on
pause(0.0001)

%calculo delta
delta=y-yprima;
    % actualizo los pesos
    for ii=1:1:ntraining
        %wi_1(ii,1) =w(1,1)-alpha*x(ii,1)*delta(ii,1);
        wi_1(ii,1) =w-rho*q(ii,1)*delta(ii,1);
        bi_1(ii,1)=b-rho*delta(ii,1);
    end
w=sum(wi_1)/ntraining;
b=sum(bi_1)/ntraining;
end
hold off

%Comprobacion de la red con resultados nuevos
%calculo la prediccion del test
yt=qt*w+b;
%compruebo el error entre los datos del test y el entrenamiento
errort=(1/(2*ntest))*sum((yt-yprimat).^2);

% 
% figure
% plot(yt,dt,'o')
% hold on
% plot([0,100],[0,100])
% hold off

figure
plot(q,y)
hold on
plot(qt,yt,'o')
hold off

