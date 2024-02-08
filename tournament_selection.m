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
                        a = pool(randi(numel(pool)));
                    % pick at random another chromosome
                    % (without replacement of a)
                        b = pool(randi(numel(pool)));
                    % check a and b arent the same and if it is,
                    % choose another b
                        while(a == b)
                            b = pool(randi(numel(pool))) ;
                        end
                    % take the fittest chromosome from both groups
                    if(max(population(a,31),population(b,31)) == population(a,31))
                            choice(1,i) = a;
                    else
                            choice(1,i) = b;
                    end
                end
                parent_chromosome_1 = population(choice(1,1),1:30);
                parent_chromosome_2 = population(choice(1,2),1:30);