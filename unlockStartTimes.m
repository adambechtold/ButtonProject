% Unpacks the ouput from the collection process and returns the array of 
% button timestamps.

function f = unlockStartTimes(rWs)
    startTimes = rWs(3);
    startTimes = startTimes{1};
    
    f = startTimes;
end
