%% Crossover Algorithm: K-point crossover
    % for this operator K points are chosen randomly and crossovers
    % are are used for crossover points on the two selected parents
    % here we randomly pick k from [1,2]
function [parent_chromosome_1, parent_chromosome_2] = k_point_crossover(parent_chromosome_1, parent_chromosome_2)
        % cross_point = [];
        % points=randi([1,2]);
        prev1 = parent_chromosome_1;
        prev2 = parent_chromosome_2;
        value = rand;
        %% One Point Crossover
            if (value < 0.3)
                %points = 1;
                    cross_point = randi([1,30]);
                    % alleles from cross point to the end swapped
                    parent_chromosome_1(cross_point:30) = prev2(cross_point:30);
                    parent_chromosome_2(cross_point:30) = prev1(cross_point:30);
        %% Two Point Crossover
            elseif value > 0.3
                cross_point = randi([1,30],1,2);
                    while cross_point(1)==cross_point(2)
                        cross_point = randi([1,30],2,1);
                    end
                % alleles between the cross points swapped
                parent_chromosome_1(min(cross_point):max(cross_point)) = prev2(min(cross_point):max(cross_point));
                parent_chromosome_2(min(cross_point):max(cross_point)) = prev1(min(cross_point):max(cross_point));                    
            end
