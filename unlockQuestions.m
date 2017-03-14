% Unpacks the ouput from the collection process and returns an array of 
% strings. The integers collected during the recording map to specific 
% strings.


function f = unlockQuestions(rWs)
    questions = rWs(2);
    questions = questions{1};
    
    strs = ' START    ';
    
    [items, ~] = size(questions);
    
    for i = 2:items
        n = questions(i);
        switch n
            case 1
                strs = [strs; ' SLOW DOWN'];
            case 2
                strs = [strs; ' SPEED UP '];
            case 3
                strs = [strs; ' QUESTION '];
            case 11
                strs = [strs; ' END      '];
    end
    
    f = strs;
end