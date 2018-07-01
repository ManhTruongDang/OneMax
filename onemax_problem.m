clear 
clc

%% Configurable parameters
num_of_chromosomes = 100;
crossover_rate = 0.7;
mutation_rate = 0.05;
chromosome_size = 100;
fitness_score = @(candidate) sum(candidate);
target_score = chromosome_size;
selection_probability = 0.7;

%% Initialize the population
population = cell(1, num_of_chromosomes);
for i = 1 : num_of_chromosomes        
    new_member = randi(2,1, chromosome_size) - 1; % 0 or 1
    population{i} = new_member;
end

%% Begin
fitness_scores = zeros(1, num_of_chromosomes);
iter_num = 1;
found_solution = 0;
while 1
    % Test each chromosome to see how good it is at solving the problem 
    % at hand and assign a fitness score accordingly. The fitness score 
    % is a measure of how good that chromosome is at solving the problem 
    new_population = cell(1, num_of_chromosomes);
    current_best = [];
    best_fitness_score = -1;
    for i = 1 : num_of_chromosomes 
        fitness_score_of_chromosome = fitness_score(population{i});
        fitness_scores(i) = fitness_score_of_chromosome;
        if best_fitness_score < fitness_score_of_chromosome
            current_best = population{i};
            best_fitness_score = fitness_score_of_chromosome;
        end
        if fitness_score_of_chromosome == target_score            
            found_solution = 1;
            break;
        end
        
    end
    if found_solution == 1
        break;
    end
    fprintf('Iteration %d, best: %s, score %d; mean: %f \n', iter_num, binary_sequence_as_string_without_space(current_best), ...
        best_fitness_score, mean(fitness_scores));
    
    new_idx = 1;
    % Elitism
    new_population{new_idx} = current_best;
    new_idx = new_idx + 1;
    
    while 1
        % Select two members from the current population        
        if sum(fitness_scores)==0
            prob_vector = ones(1, num_of_chromosomes) * (1 / num_of_chromosomes);
        else
            prob_vector = fitness_scores ./ sum(fitness_scores);
        end  
        % [member_1_index, member_2_index ] = select_2_members_using_roulette_wheel(num_of_chromosomes, prob_vector);
        [member_1_index, member_2_index ] = select_2_members_using_tournament_selection(num_of_chromosomes, fitness_scores, ...
            selection_probability);
        member_1 = population{member_1_index};
        member_2 = population{member_2_index};
        
        % Depending on the crossover rate crossover the bits from each chosen 
        % chromosome at a randomly chosen point
        do_a_crossover = randsample([false true], 1, true, [(1-crossover_rate) crossover_rate]);
        if do_a_crossover
            % num_of_total_crossovers = num_of_total_crossovers + 1;            
            [new_member_1, new_member_2] = crossover(member_1, member_2);
        end
        
        % Step through the chosen chromosomes bits and flip depending on the
        % mutation rate.
        if do_a_crossover
            [new_member_1, new_member_2, num_of_mutated] = mutation(...
                new_member_1, new_member_2, mutation_rate);
        else
            [new_member_1, new_member_2, num_of_mutated] = mutation(...
                member_1, member_2, mutation_rate);
        end
        % num_of_total_mutations = num_of_total_mutations + num_of_mutated;
        new_population{new_idx} = new_member_1;
        new_idx = new_idx + 1;
        new_population{new_idx} = new_member_2;
        new_idx = new_idx + 1;        
        if new_idx > num_of_chromosomes
            iter_num = iter_num + 1;      
            population = new_population;
            break;
        end
    end
end

%% The end
fprintf('Solution: %s at iteration %d \n', binary_sequence_as_string_without_space(current_best), iter_num);
