function [inputSignals, timeVector] = mimoInputGenerator(numInputs, numSamples, sampleRate)
    % numInputs: Number of input channels
    % numSamples: Number of samples for each input channel
    % sampleRate: Sampling rate in Hz

    % Generate time vector
    timeVector = (0:numSamples-1) / sampleRate;

    % Initialize inputSignals matrix
    inputSignals = zeros(numSamples, numInputs);

    % Generate random signals for each input channel
    for i = 1:numInputs
        % Example: Generating random signals with amplitude between -1 and 1
        inputSignals(:, i) = 2 * (rand(numSamples, 1) - 0.5);
    end

    % You can customize the signal generation process based on your requirements

    % Plot the generated signals
    figure;
    for i = 1:numInputs
        subplot(numInputs, 1, i);
        plot(timeVector, inputSignals(:, i));
        xlabel('Time (s)');
        ylabel(['Input ', num2str(i)]);
        title(['MIMO Input Signal ', num2str(i)]);
    end
end
