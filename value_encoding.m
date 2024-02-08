%% Mutation Algorithm: Mutation with Value Encoding
    % within the ranges of values it takes   
    % advance at random [1,3] places for orientation alleles
    % advane 1 step for fsm alleles
    % if get to end of interval eg 4 in [1,4] then loop to start(1)
function [parent_chromosome_1, parent_chromosome_2] = value_encoding(parent_chromosome_1, parent_chromosome_2, ori)
        if (rand < 0.4)
            % mutation for parent 1
                mpoint = randi([1,30]);
                steps = randi([1,3]);
                % for points index ([1,9]x3)+1 range is [1,4]
                if ismember(mpoint,ori)
                    % if the mod of the value of allele + steps with 4 is 0,
                    % the value of the allele will be 0
                    if(mod(parent_chromosome_1(mpoint) + steps,4))
                         parent_chromosome_1(mpoint) = 4;
                     % otherwise set it to be the value of the allele
                    else
                        parent_chromosome_1(mpoint) = mod(parent_chromosome_1(mpoint) + steps,4);
                    end
                % for all other points, range is [0,9]
                else
                    if parent_chromosome_1(mpoint) == 9
                        parent_chromosome_1(mpoint) = 0;
                    else
                        parent_chromosome_1(mpoint) = parent_chromosome_1(mpoint)+1;
                    end
                end
        end
         if (rand < 0.4)
            % mutation for parent 2
                mpoint = randi([1,30]);
                % for points index ([1,9]x3)+1 range is [1,4]
                if ismember(mpoint,ori)
                    if parent_chromosome_2(mpoint) == 4
                        parent_chromosome_2(mpoint) = 1;     
                    else
                        parent_chromosome_2(mpoint) = parent_chromosome_2(mpoint) + 1;
                    end
                % for all other points, range is [0,9]
                else
                    if parent_chromosome_2(mpoint) == 9
                        parent_chromosome_2(mpoint) = 0;
                    else
                        parent_chromosome_2(mpoint) = parent_chromosome_2(mpoint)+1;
                    end
                end
        end