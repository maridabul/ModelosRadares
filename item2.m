pd = 0.9;
pfa = 1e-4;

M = 1e8;

desvioPadrao = 0.7;

N = normrnd(0,desvioPadrao,[M, 1]) + 1i*normrnd(0,desvioPadrao,[M, 1]);

%%%%%%%%% item 2 %%%%%%%%% 

%Cálculo de SNR utilizando a  função  de  Shnidman:
%SNR em db
SNR = shnidman (pd, pfa);
%Converter SNR de db para potência
SNR = db2pow (SNR);

%calculo do módulo e fase do sinal do alvo
modulo = desvioPadrao*sqrt(2*SNR);

fase = pi * (rand(M,1) - 0.5);
Zalvo = modulo*exp(1i*fase);

clear modulo;
clear fase;

Z = N + Zalvo;

clear N;
clear Zalvo;

%Ao considerar um detector do tipo "squared law", tem-se:
W = (abs(Z)).^2; 

clear Z;

%Quantos alvos foram detectados:
limiar = 2*(desvioPadrao^2)*log(1/pfa);

quantidadeAlvoDetectado = sum(W > limiar);

clear W;

%pd estimado:

pdEstimado = quantidadeAlvoDetectado / cast(M, 'double');
