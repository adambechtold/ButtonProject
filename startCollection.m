%{
startCollection sets up the arduino at the default port for this computer
It listens to the lecture from the computer's default microphone. 
Input from the Arduino board is collected. When the user presses a button,
a timestamp is collected along with which button was pressed. Each button
has a different meaning:
    - Red button: slow down
    - Green button: speed up
    - Blue button: I have a question
    - Yellow button: the program ends and the data is packaged.
This feedback is printed to the screen for development purposes and an LED
blinks on the board to give the user feedback that their response has been
collected.

The data is packaged into a cell array and returned.
%}

function f = startCollection

    %Defulat arduino port:
    port = '/dev/tty.usbserial-DN02BEP0';

    %set up board
    board = arduino(port, 'Uno');
    
    %set up visual feedback pins
    ledFeedback = 'D13';
    %ledGreen = ...;
    %ledRed = ...;
    
    %set up read button pins
    buttonRedPin = 'D2';
    buttonGreenPin = 'D3';
    buttonBluePin = 'D4';
    buttonYellowPin = 'D5';
    
    %audio settings
    recObj = audiorecorder;
    startTime = clock;
    record(recObj);
    
    timeStamps = [0, startTime];
    disp('start lecture');
    
    %loop()
    while(1 == 1) 
        if(not(readDigitalPin(board, buttonRedPin)))
            %red button pressed
            writeDigitalPin(board, ledFeedback, 1);
            disp('Slow down');
            stamp = [1, clock];
            timeStamps = [timeStamps; stamp];
            
        elseif (not(readDigitalPin(board, buttonGreenPin)))
            %green button pressed
            writeDigitalPin(board, ledFeedback, 1);
            disp('Speed up');
            stamp = [2, clock];
            timeStamps = [timeStamps; stamp];
            
        elseif (not(readDigitalPin(board, buttonBluePin)))
            %blue button pressed
            writeDigitalPin(board, ledFeedback, 1);
            disp('I have a question about that');
            stamp = [3, clock];
            timeStamps = [timeStamps; stamp];
            
        elseif (not(readDigitalPin(board, buttonYellowPin)))
            %yellow button pressed
            writeDigitalPin(board, ledFeedback, 1);
            disp('stop recording');
            break;
            
        else
            % turn off the feedback LED
            writeDigitalPin(board, ledFeedback, 0);
        end
        
        pause(0.3);
    end
    
    %end recording
    stop(recObj);
    stamp = [11, clock];
    timeStamps = [timeStamps; stamp];
    
    %post processing
    [stamps, ~] = size(timeStamps);
    
    startTimes = [0];
    responseTypes = [0];
    
    for i = 2:stamps
        %append new start time at the bottom of startTimes array
        startTimes = [startTimes; etime(timeStamps(i, 2:end), startTime)];
        responseTypes = [responseTypes; timeStamps(i,1)];
    end
    
    %return 1X2 cell array
    f = {recObj, responseTypes, startTimes};
end