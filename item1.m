%A probabilidade de detec��o e a probabilidade de falso alarme:
pd = 0.9;
pfa = 1e-4;

%Como a pfa � 10^-4, a prob. de falso positivo � 1 a cada 10000 amostras
%Ent�o M >> 1e4 realiza��es, pra garantir que o falso positivo ocorra 
%vezes o suficiente
M = 1e8;

%Desvio padr�o do ru�do branco:
desvioPadrao = 0.7;

%N � um ruido branco, complexo e gaussiano com potencia pre-fixada
%Tem-se uma VA na forma Z=X+iY, com X e Y sendo i.i.d.
N = normrnd(0,desvioPadrao,[M, 1]) + 1i*normrnd(0,desvioPadrao,[M, 1]);

%%%%%%%%% item 1 %%%%%%%%% 

%Como Z=X+iY=modulo*e^(j*fase), pode-se calcular o m�dulo:
modulo = abs(N);

clear N;

%Ao considerar um detector do tipo "squared law", tem-se:
N = abs(modulo).^2; 

clear modulo;

%Agora, analisar quantos falso alarmes ocorreram:

limiar = 2*(desvioPadrao^2)*log(1/pfa);

quantidadeFalsoAlarmes = length(find(N > limiar));

clear N;

%A pfa estimada:

pfaEstimada = quantidadeFalsoAlarmes / cast(M, 'double');

