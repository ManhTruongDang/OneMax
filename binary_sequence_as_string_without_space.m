function [output ] = binary_sequence_as_string_without_space(input )
% input: 1xN array
% output: String with all spaces removed
temp = num2str(input);
temp(isspace(temp)) = [];
output = temp;

end

