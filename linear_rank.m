%% Selection Algorithm: Linear Rank Selection
    % The population is ranked and every chromosome recieves
    % fitness from this ranking
        % rank population, worst having fitness 1,
        % best fitness N(number of chromosomes in population)
function [parent_chromosome_1, parent_chromosome_2] = linear_rank(population, population_size)

                    population = sortrows(population,31);
                % give probability of selection by the rank/(sum of rankings)
                     weights = zeros(population_size,1);
                     for i = 1:population_size
                         % using gauss formular for sum of rankings
                        weights(i) = i/((population_size+1)*population_size/2);
                     end
                % Do the roulette selection with these probabilities
                % using roulette function from Roulette.m
                 choice1 = Roulette(weights);
                 choice2 = Roulette(weights);
                    % make sure doesnt pick the same chromosome
                    while (choice2 == choice1)
                        choice2 = Roulette(weights);
                    end
                parent_chromosome_1 = population(choice1, 1:30);
                parent_chromosome_2 = population(choice2, 1:30);
