% Unpacks the ouput from the collection process and returns the audio
% sample

function f = unlockAudio(rWs)
    audio = rWs(1);
    audio = audio{1};

    f = audio;
end