function [code_num] = mic_paper_to_code(paper_num)
%MIC_PAPER_TO_CODE Transforms the mic numbers from the paper to the ones
%used in the code    
    correspondencies = [1,8,11,6,5,15,2,19,3,9,13,4,12,14,17];
    code_num = correspondencies(paper_num);
end

