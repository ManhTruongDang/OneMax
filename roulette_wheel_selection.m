function [idx ] = roulette_wheel_selection(num_of_chromosomes, prob_vector)
idx = randsample(1:num_of_chromosomes, 1, true, prob_vector); % Requires Statistic toolbox

end

