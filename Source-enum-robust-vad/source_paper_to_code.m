function [code_num] = source_paper_to_code(paper_let)
%SOURCE_PAPER_TO_CODE Transforms the source letters from the paper to the 
%source numberrs used in the code
    code_num = zeros(size(paper_let));
    
    j = 1;
    for i = 1:length(paper_let)
        switch paper_let(i)
            case 'A'
                code_num(j) = 7;
                j = j+1;
            case 'B'
                code_num(j) = 5;
                j = j+1;
            case 'C'
                code_num(j) = 8;
                j = j+1;
            case 'D'
                code_num([j,j+1]) = [2,4];
                j = j+2;
            case 'E'
                code_num(j) = 11;
                j = j+1;
            case 'F'
                code_num(j) = 12;
                j = j+1;
            otherwise
                code_num(j) = -1;
                j = j+1;
        end
    end

end

