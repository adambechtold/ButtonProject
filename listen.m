%{
listen takes the output from startCollection and allows the user to 
cycle through the different input the student gave.

The cell array is unpacked using the different "unlock" functions. 

The playback parameters defined at the beginning for the function give
 the user the ability to select what kind of audio playback they want to
 hear. The entire lecture has been recorded and the timestamp gives the 
 time of the button press. Modifing these paramters allow the user to 
 specify how much they want to hear before the button press and how much 
 they want to hear after the button press.

The program then loops through all of the timestamps. It notifies the user
 of what kind of press this was (question, speedup, slow down, stop) and 
 gives them the option to listen or to pass.
%}

function listen(f)

    %unpack the data
    audio = unlockAudio(f);
    questions = unlockQuestions(f);
    times = unlockStartTimes(f);

    [cycles, ~] = size(times);
    sr = audio.SampleRate;
    
    %playback parameters
    beforePress = 4;
    afterPress = 2;
    totalTime = beforePress + afterPress;
    
    disp('response type, start time');
    
    %cycle through audio
    for i = 1:cycles
        disp(i)
        %display type
        displayText = strcat('response: ', num2str(i), ' is of type: ', questions(i,1:end)); 
        disp(displayText);
        user = input('press 1 to listen, 2 to pass: ');
        if isempty(user)
            user = 1;
        end
        
        if (user == 1)
            %playback settings
            startTime = floor(sr * times(i) - beforePress*sr);
            endTime = floor(sr * times(i) + afterPress*sr);
            if (startTime < 0) %if start time befoer
                startTime = 1;
                endTime = sr*totalTime;
            end
     
            %audio listen
            play(audio, [startTime endTime])
            pause(6);
        end
        
    end

end