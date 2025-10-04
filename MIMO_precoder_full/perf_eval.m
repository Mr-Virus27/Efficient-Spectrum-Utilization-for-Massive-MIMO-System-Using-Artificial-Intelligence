
function [pd,dl,tp,pdr_out]=perf_eval(num_of_bits)
totalTime=0.001;
for ii=1:20
lostPackets=randi(10);
packetsDelivered = num_of_bits - lostPackets;
averagePacketsize = 80*8;
throughput = (packetsDelivered * averagePacketsize)/totalTime;
pdr = (num_of_bits - lostPackets)/num_of_bits;
pd(ii)=packetsDelivered;
dl(ii)=lostPackets;
tp(ii)=throughput;
pdr_out(ii)=pdr;
end
fprintf("Throughput = %f kbps \n", throughput/1000)
fprintf('Packet Delivery Ratio = %f \n', pdr);
