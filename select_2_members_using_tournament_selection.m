function [member_1_index, member_2_index ] = select_2_members_using_tournament_selection(num_of_chromosomes, fitness_scores, ...
    selection_probability)
% member_1_index = roulette_wheel_selection(num_of_chromosomes, prob_vector);
% while 1
%     member_2_index = roulette_wheel_selection(num_of_chromosomes, prob_vector);
%     if member_2_index ~= member_1_index                
%         break;
%     end
% end
one_divided_by_num_of_chromosomes = 1 / num_of_chromosomes;
idx_1 = randsample(1:num_of_chromosomes, 1, true, one_divided_by_num_of_chromosomes * ones(1, num_of_chromosomes));
idx_2 = randsample(1:num_of_chromosomes, 1, true, one_divided_by_num_of_chromosomes * ones(1, num_of_chromosomes));
if rand < selection_probability
    if fitness_scores(idx_1) > fitness_scores(idx_2)
        member_1_index = idx_1;
    else
        member_1_index = idx_2;
    end
else
    if fitness_scores(idx_1) < fitness_scores(idx_2)
        member_1_index = idx_1;
    else
        member_1_index = idx_2;
    end
end
idx_1 = randsample(1:num_of_chromosomes, 1, true, one_divided_by_num_of_chromosomes * ones(1, num_of_chromosomes));
idx_2 = randsample(1:num_of_chromosomes, 1, true, one_divided_by_num_of_chromosomes * ones(1, num_of_chromosomes));
if rand < selection_probability
    if fitness_scores(idx_1) > fitness_scores(idx_2)
        member_2_index = idx_1;
    else
        member_2_index = idx_2;
    end
else
    if fitness_scores(idx_1) < fitness_scores(idx_2)
        member_2_index = idx_1;
    else
        member_2_index = idx_2;
    end
end

end

