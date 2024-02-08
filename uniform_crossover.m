%% Crossover Algorithm: Uniform Crossover
    % for this operator, numbers are randomly generated for each
    % allele in a chromosome
    % if the value at this allele >= probability then allele swapped
    % if value at this allele < probability, then allele not swapped

function [parent_chromosome_1, parent_chromosome_2] = uniform_crossover(parent_chromosome_1, parent_chromosome_2)
 
            % temporarily store previous chromosomes for swapping
                prev1 = parent_chromosome_1;
                prev2 = parent_chromosome_2;
            % generate random values between(0,1) for each allele
                values = rand(1,30);
                for i = 1:30
                    % swap if values >= swapping probability
                       if values(i) >= 0.5 
                            parent_chromosome_1(i) = prev2(i); 
                            parent_chromosome_2(i) = prev1(i);
                       end
                end
