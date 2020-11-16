%A probabilidade de detecção e a probabilidade de falso alarme:
pd = 0.9;
pfa = 1e-4;

%Como a pfa é 10^-4, a prob. de falso positivo é 1 a cada 10000 amostras
%Então M >> 1e4 realizações, pra garantir que o falso positivo ocorra 
%vezes o suficiente
M = 1e8;

%Desvio padrão do ruído branco:
desvioPadrao = 0.7;

%N é um ruido branco, complexo e gaussiano com potencia pre-fixada
%Tem-se uma VA na forma Z=X+iY, com X e Y sendo i.i.d.
N = normrnd(0,desvioPadrao,[M, 1]) + 1i*normrnd(0,desvioPadrao,[M, 1]);

%%%%%%%%% item 1 %%%%%%%%% 

%Como Z=X+iY=modulo*e^(j*fase), pode-se calcular o módulo:
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

