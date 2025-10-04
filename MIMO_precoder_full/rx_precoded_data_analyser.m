function [rx_mimo]=rx_precoded_data_analyser(sampleRate)
numInputs=4; % Number of channels
numSamples=1000; %Samples
% sampleRate;
M=4;
for i=1:M
[inputSignals, timeVector]=mimoInputGenerator(numInputs, numSamples, sampleRate);
% title(['Channel' num2str(M)])
end
input_ut=inputSignals(:,1);
[y1]=tx_precoder(input_ut);
input_ut=inputSignals(:,2);
[y2]=tx_precoder(input_ut);
input_ut=inputSignals(:,3);
[y3]=tx_precoder(input_ut);
input_ut=inputSignals(:,4);
[y4]=tx_precoder(input_ut);

MIMO_input_tx=[y1;y2;y3;y4];
Gx_gen=rand(50);
Gx_add=Gx_gen(1:1000);

ndy1=y1(1,:);
ndy2=y2(1,:);
ndy3=y3(1,:);
ndy4=y4(1,:);
% Channel Mixing
n=1;
for i=1:1000
    tx_mimo_c1(i)=ndy1(i)*Gx_add(i)+n; % Linear Mixing with Random Probablistic Channel noise
    tx_mimo_c2(i)=ndy2(i)*Gx_add(i)+n;
    tx_mimo_c3(i)=ndy3(i)*Gx_add(i)+n;
    tx_mimo_c4(i)=ndy4(i)*Gx_add(i)+n;    
end
rx_mimo=[tx_mimo_c1;tx_mimo_c2;tx_mimo_c3;tx_mimo_c4];