%% Generating initial population
    % ori is the indicies of the orientation alleles which takes values
    % [1,4]
    % the remaining alleles are FSM alleles which takes values [0,9]
function population = generate_population(ori,population_size)
    population = zeros(population_size,30);
    % Randomly generate each chromosome in the population
        for n = 1:population_size
            for i = 1:30
                if ismember(i,ori)
                     % random number in [1,4] for orientation alleles
                     population(n,i) = randi([1,4]);
                else
                    % random number in [0,9] for fsm alleles
                    population(n,i) = randi([0,9]);
                end
            end
        end
    
 %{
    Generating initial population, in a different way:
        for n = 1:population_size
            chromosome = zeros(10, 3);
            for i = 1:10
                for j = 1:3
                    % random number in [1,4]
                    if(j == 1)
                        chromosome(i,j) = randi([1,4]);
                    else
                    chromosome(i,j) = randi([0,9]);
                    end
                end
            end
            % add chromosome to the population
            population(n,:) =  reshape(chromosome',1,[]);
        end
%}
