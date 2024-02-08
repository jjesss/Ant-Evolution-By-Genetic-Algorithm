%% Mutation Algorithm:Insertion Mutation
        % select values at random within range eg.[1,4] or [0,9]
        % insert it into a random position in chromosome
        % mutate for both ori alleles and fsm alleles
function [parent_chromosome_1, parent_chromosome_2] = insertion(parent_chromosome_1, parent_chromosome_2,ori)
    % mutation of parent 1
        if (rand < 0.2)                        
            switch_point1 = randi([1,30]);
            % for a random ori allele replace from a value in [1,4]
            while ~ismember(switch_point1,ori) 
                switch_point1 = randi([1,30]);
            end
            parent_chromosome_1(switch_point1) = randi([1,4]);
    
            % for a random fsm alleles replace from a value in [0,9]
            while ismember(switch_point1,ori)
                switch_point1 = randi([1,30]);
            end
            parent_chromosome_1(switch_point1) = randi([0,9]);
        end
        
    % mutation of parent 2
        if (rand < 0.2)
            % mutate for both ori alleles and fsm alleles
    
            switch_point1 = randi([1,30]);
            % for a random ori allele replace from a value in [1,4]
            while ~ismember(switch_point1,ori)
                switch_point1 = randi([1,30]);
            end
            parent_chromosome_2(switch_point1) = randi([1,4]);
    
            % for a random fsm alleles replace from a value in [0,9] 
            while ismember(switch_point1,ori) 
                switch_point1 = randi([1,30]);
            end
            parent_chromosome_2(switch_point1) = randi([0,9]);
        end