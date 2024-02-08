%% Mutation Algorithm: Exchange Mutation
% ori is the indexes of orientation alleles
% two locations within a chromosome are selected at random and their values are exchanged 
function [parent_chromosome_1, parent_chromosome_2] = exchange_mutation(parent_chromosome_1,parent_chromosome_2,ori)
            
            prev1 = parent_chromosome_1;
            prev2 = parent_chromosome_2;
                % mutation of parent 1
                if (rand < 0.3)
                    % condition: the points must both be ori alleles or
                    % both not and the points cant be the same
                    switch_point1 = randi([1,30]);
                    switch_point2 = randi([1,30]);
                    % mutate for both ori alleles and fsm alleles
                            % swap two different ori alleles
                            while ~ismember(switch_point1,ori) 
                                switch_point1 = randi([1,30]);
                            end
                            while ~ismember(switch_point2,ori) || switch_point1 == switch_point2
                                 switch_point2 = randi([1,30]);
                            end
                            parent_chromosome_1(switch_point1) = prev1(switch_point2);
                            parent_chromosome_1(switch_point2) = prev1(switch_point1);

                            % swap two different fsm alleles
                            while ismember(switch_point1,ori)
                                switch_point1 = randi([1,30]);
                            end
                            while ismember(switch_point2,ori) || switch_point1 == switch_point2
                                switch_point2 = randi([1,30]);
                            end
                                parent_chromosome_1(switch_point1) = prev1(switch_point2);
                                parent_chromosome_1(switch_point2) = prev1(switch_point1);
                end
                % mutation of parent 2
                if (rand < 0.3)
                    % condition: the points must both be ori alleles or
                    % both not and the points cant be the same
                    switch_point1 = randi([1,30]);
                    switch_point2 = randi([1,30]);
                            % mutate for both ori alleles and fsm alleles
                            % swap two different ori alleles
                            while ~ismember(switch_point1,ori) 
                                switch_point1 = randi([1,30]);
                            end
                            while ~ismember(switch_point2,ori) || switch_point1 == switch_point2
                                 switch_point2 = randi([1,30]);
                            end
                            parent_chromosome_2(switch_point1) = prev2(switch_point2);
                            parent_chromosome_2(switch_point2) = prev2(switch_point1);

                            % swap two different fsm alleles
                            while ismember(switch_point1,ori)
                                switch_point1 = randi([1,30]);
                            end
                            while ismember(switch_point2,ori) || switch_point1 == switch_point2
                                switch_point2 = randi([1,30]);
                            end        
                            parent_chromosome_2(switch_point1) = prev2(switch_point2);
                            parent_chromosome_2(switch_point2) = prev2(switch_point1);
                end
            end
            