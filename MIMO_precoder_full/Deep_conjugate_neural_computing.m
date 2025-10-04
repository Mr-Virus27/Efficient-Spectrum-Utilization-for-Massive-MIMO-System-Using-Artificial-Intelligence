function [FN,FP,TN,TP,conmat,c_0,c_1,class,et,y]=Deep_conjugate_neural_computing(x,t)

% Deep_conjugate_neural_computing
trainFcn = 'trainscg'; 
% Gradient PATTERn NETWORK 
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize, trainFcn);
 
% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};
 
% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 85/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = 5/100;
 
% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'crossentropy';  % Cross-Entropy
%  inp=f(3);
% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotconfusion', 'plotroc'};
 
% Train the Network
[net,tr] = train(net,x,t);
 
% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);
 
% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,y)
valPerformance = perform(net,valTargets,y)
testPerformance = perform(net,testTargets,y)
 
% View the Network
% view(net)
 
% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
% figure, plotconfusion(t,y)
%figure, plotroc(t,y)
 
if (false)
    genFunction(net,'myNeuralNetworkFunction');
    y = myNeuralNetworkFunction(x);
end
if (false)
    genFunction(net,'myNeuralNetworkFunction','MatrixOnly','yes');
    y = myNeuralNetworkFunction(x);
end
if (false)
    gensim(net);
end

FN=0;
FP=0;
TN=0;
TP=0;
loopk=1;
[c,cm,ind,per] = confusion((t),(y));
if loopk==1
conmat=per;
[rk ck]=size(per);
for i=1:rk
FN=FN+per(i,1);
FP=FP+per(i,2);
TP=TP+per(i,3);
TN=TN+per(i,4);
end
end
 
[rr cc]=size(cm);
for i=1:rr
    for j=1:cc
       if(cm(i,j)>50)
           stamp1=i;
           stamp2=j;
       end
    end
end
stamp=stamp1+stamp2;
if stamp>2
    class=1;
else
    class=0;
end
c_0=sum(per(1,:));
c_1=sum(per(2,:));
% end
% fprintf('Error Check \n');
et=max(percentErrors);
% pause(5);
%  class=str2num(f(3));
end
