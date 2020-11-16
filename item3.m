pd = 0.9;
pfa = 1e-4;

M = 1e8;

desvioPadrao = 0.7;

N = normrnd(0,desvioPadrao,[M, 1]) + 1i*normrnd(0,desvioPadrao,[M, 1]);

%%%%%%%%% item 3 %%%%%%%%% 

%Cálculo do novo SNR:
SNR = shnidman (pd, pfa, 1, 1);
SNR = db2pow (SNR);

% SNR = pAlvo/pRuido
% pRuido = pRuidoX + pRuidoY = (desvioPadrao^2) + (desvioPadrao^2)
% pRuido = 2*(desvioPadrao^2)
pAlvo = SNR*2*(desvioPadrao^2);

%calculo do módulo e fase do novo sinal do alvo:
modulo = sqrt(-pAlvo*log(1-rand(M,1)));
fase = pi * (rand(M,1) - 0.5);
Zalvo = modulo.*exp(1i*fase);

clear fase;
clear modulo;

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

pdEstimado = quantidadeAlvoDetectado / cast(M, 'double');
