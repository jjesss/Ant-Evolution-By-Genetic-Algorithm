%% Selection Algorithm: Tournament Selection
            % chromosomes randomly selected from population
            % then best chromosome selected from this group 
            % (with/without replacement)
function [parent_chromosome_1, parent_chromosome_2] = tournament_selection(parent_chromosome_1, parent_chromosome_2, population, population_size)
                choice = zeros(1,2);
                pool = 1:population_size;
                % 2 groups so we can have two surviving chromosomes
                for i= 1:2
                    % pick at random one chromosome number
                    % pick at random another chromosome
                    % (without replacement of a)
                        % a = pool(randi(numel(pool)));
                        % b = pool(randi(numel(pool)));                                            
                        indices = randperm(population_size, 2);  
                        a = indices(1);
                        b = indices(2);
                        
                    % check a and b arent the same and if it is,
                    % choose another b
                        % while(a == b)
                            % b = pool(randi(numel(pool))) ;
                        % end
                    % take the fittest chromosome from both groups
                    
                    if population(a, 31) > population(b, 31)
                                choice(i) = a;
                    else
                                choice(i) = b;
                    end
                end
                parent_chromosome_1 = population(choice(1),1:30);
                parent_chromosome_2 = population(choice(2),1:30);
end
