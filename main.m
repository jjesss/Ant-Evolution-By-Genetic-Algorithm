% The function simulate_ant outputs the overall fitness value and trail the
% ant takes
% It takes the genetic encoding for an an( string_controller containing 30
% digits) and the file containing the enviroment

% In this project we use Genetic Algorithm to try and build a better ant through evolution
% Each ant must survive on its own in a world represented by a 2D grid of cells by following trails of food
% The fitness of the ant is rated by counting how many food elements it consumes in 200 time-steps
% The controller for our ant will consist of a 10-state finite state machine (FSM).
% The ant's orientation takes values 1, 2, 3, 4 representing east, north, west, south respectively.

% save cell map into a matrix
map = dlmread('muir_world.txt',' '); 

% Ask user to select what types of selection, cross-over and mutation used
    %% Choosing selection:
        prompt = "Choose the selection method you would like to use out of the following:\n" + ...
            "   if invalid selected defult will be 1\n" + ...
            "   1.Roulette Selection 2.Tournament Selection 3.Linear Rank Selection:\n";
            selection = input(prompt);
        
            % defult set if non valid input given
            valid_s = [1,2,3];
            if( ~ismember(selection,valid_s))  
                selection = 1;
            end
    %% Choosing Cross-over:
        prompt = "Choose the cross over method you would like to use out of the following:\n" + ...
            "   if invalid selected defult will be 1\n" + ...
            "   1.k-point crossover 2.Uniform Crossover:\n";
        cross_over = input(prompt);
            
            % defult set if non valid input given
            valid_c = [1,2];
            if( ~ismember(cross_over,valid_c))  
                cross_over = 1;
            end
    %% Choosing Mutation:
        prompt = "Choose the mutation operators you would like to use out of the following:\n" + ...
            "   if invalid selected defult will be 1\n" + ...
            "   1.Mutation with Value Encoding 2. Insertion Mutation:\n";
            mutation = input(prompt);
        
           % defult set if non valid input given
            valid_m = [1,2];
            if( ~ismember(mutation,valid_m))  
                mutation = 1;
            end 
    
%% Initialise iteration number and population size
Ngen = 1000; % number of generations
population_size = 300; % number of chromosomes in a population
fitness_data = zeros(1,Ngen);

% find orientation allele points
    % ori is the indicies of the orientation alleles which takes values [1,4]
    % the remaining alleles are FSM alleles which takes values [0,9]
    ori = zeros(1,10);
    n=1;
    for i = 1:30
                if mod(i,3)==1
                    ori(n) = i;
                    n = n+1;
                end
    end
%% Generate initial population
     population = generate_population(ori,population_size);
               
% add another column at the end for the fitness value
    population = [population zeros(population_size,1)];

% I implement two End Condition Strategies
% If the end conditions are satisfied, stop and return best solution in the
% current population
    % (1) When a max number of 1000 generations has been produced OR
    % (2) When the average fitness value of population remains fixed 
    %     for several iterations
last_mean = 100;
%% End condition (1):
for iter=1:Ngen  % Each generation generates a new population until max produced
    %% Calculate the fitness of each chromosome
    for i = 1: population_size
         population(i,31) = simulate_ant(map,population(i,1:30));
    end
    
    %% End Condition (2):
        % average fitness value of population remains fixed for several iterations
        N = 150; % required number of consecutive generations that produce 
                 % the same fitness value
        % create a 1 x population size vector of fitness values
        current_fitness = reshape(population(1:population_size,31)',1,[]);
            % for every 50 iterations
            if mod(iter,N) == 0 
                % calc average fitness of population:
                current_mean = mean(current_fitness);
                    % check if the change for every 50 is less than our threshold             
                    if abs(last_mean - current_mean)<= 10
                        % set the amount of generations it checked
                        Ngen = iter-1;
                        % update fitness data length
                        fitness_data = fitness_data(1:Ngen);
                        break; % stop, return best solution in current generation
                    else
                        % update last mean to current mean
                        last_mean = current_mean;
                    end
            end       

    % find fitness value of fittest chromosome in each generation
    population = sortrows(population,31);
    fitness_data(iter) =  population(end,31);

    % Two Replacement Strategies are Considered
        % when creating a new population by crossover and mutation,
        % theres a good chance the best chromosome will be lost
        % Replacememnt strategies help stop this
        % I chose to use the elitism as it adds chromosomes with best fitness
        % from the last population
            %% Elitism Replacement Strategy
                % sorts the population based on the fitness column
                % population = sortrows(population,31);
                    population_new = zeros(population_size,30);
                    % keep best 10%:
                    population_new(1:(0.2*population_size),1:30) = population(population_size-(0.2*population_size-1):population_size,1:30);
                    population_new_num = (0.2*population_size);
                % I chose to keep only the best 2 chromosomes:
                    %population_new(1:2,1:30) = population(population_size-1:population_size,1:30);
                    %population_new_num = 2;
                    
             %{
                %% Generational Replacement Strategy
                    population_new = zeros(population_size,30);
                    population_new_num = 0;
             %}
    
    
    while (population_new_num < population_size)
        % Choice of 3 different selection methods
        if selection == 1
        %% Roulette Selection : 
            % Selects chromosomes based on a probability proportional torandi([1,4])
            % the fitness
            % Chromosomes with higher fitness have more probability of
            % selection
                weights = population(:,31)/sum(population(:,31));
                % using the roulette function in Roulette.m
                choice1 = Roulette(weights);
                choice2 = Roulette(weights);
                    % make sure doesnt pick the same chromosome
                    while (choice2 == choice1)
                        choice2 = Roulette(weights);
                    end
                parent_chromosome_1 = population(choice1, 1:30);
                parent_chromosome_2 = population(choice2, 1:30);
        elseif selection == 2
        %% Tournament Selection:
            % chromosomes randomly selected from population
            % then best chromosome selected from this group 
            % (with/without replacement)
            [parent_chromosome_1, parent_chromosome_2] = tournament_selection(parent_chromosome_1, parent_chromosome_2, population, population_size);
        elseif selection == 3
        %% Linear Rank Selection
            % The population is ranked and every chromosome recieves
            % fitness from this ranking
                % rank population, worst having fitness 1,
                % best fitness N(number of chromosomes in population)
                 [parent_chromosome_1, parent_chromosome_2] = linear_rank(population, population_size);
        end
        % Choice of two Crossover Operators
        % cross over is performed with high probability 

            %% K-point crossover:
                % for this operator K points are chosen randomly and crossovers
                % are are used for crossover points on the two selected parents
                % here we randomly pick k from [1,2]
                if cross_over == 1
                   [parent_chromosome_1, parent_chromosome_2] = k_point_crossover(parent_chromosome_1, parent_chromosome_2);
            %% Uniform Crossover:
                % for this operator, numbers are randomly generated for each
                % allele in a chromosome
                % if the value at this allele >= probability then allele swapped
                % if value at this allele < probability, then allele not swapped
                elseif cross_over == 2
                       [parent_chromosome_1, parent_chromosome_2] = uniform_crossover(parent_chromosome_1, parent_chromosome_2);
                end

        %% Choice of two Mutation Operators
        % mutation is designed to overcome the problem of two parents having
        % the same allele at a given gene
        % It adds diversity to the population

            % if user chose:
            %% 1. Mutation with Value Encoding
            % within the ranges of values it takes   
            % advance at random [1,3] places for orientation alleles
            % advane 1 step for fsm alleles
            % if get to end of interval eg 4 in [1,4] then loop to start(1)
                if mutation == 1
                    [parent_chromosome_1, parent_chromosome_2] = value_encoding(parent_chromosome_1, parent_chromosome_2, ori);
            
            % if user chose:
            %% 2. Insertion Mutation
                % select values at random within range eg.[1,4] or [0,9]
                % insert it into a random position in chromosome
                % mutate for both ori alleles and fsm alleles
            
                elseif mutation == 2
                    [parent_chromosome_1, parent_chromosome_2] = insertion(parent_chromosome_1, parent_chromosome_2,ori);
                end
                
            % I replaced exchange mutation with insertion mutation 
            % As exchange  mutation is limited to the values within the chromosome 
            % so if all ori values are 1 there is no diversity added 
            % [parent_chromosome_1, parent_chromosome_2] = exchange_mutation(parent_chromosome_1,parent_chromosome_2,ori);
            
            % add to the new population
                % add parent chromosome 1 
                population_new_num = population_new_num+1;
                population_new(population_new_num,:) = parent_chromosome_1;
                % add parent chromosome 2 to the population if the new
                % population isnt full
                 if (population_new_num < population_size)
                     population_new_num = population_new_num+1;
                     population_new(population_new_num,:) = parent_chromosome_2;
                 end
    end
    % update the population with the new population
    population(:,1:30) = population_new;
end


%% Final Generation Calculations:
    % calc fitness of final generation and return the best solution
        for i = 1: population_size
            population(i,31) = simulate_ant(map,population(i,1:30));         
        end
    % sort (least fit first)
        population = sortrows(population,31);
    % gives the best fitness value of most fit ant in the final generation
        best_fitness=population(end,31);
    % find trail of most-fit ant in in the final generation
        [fitness,trail] = simulate_ant(map,population(end,1:30));  



%% Plotting the graphs:
    %% Fitness Score
    % Output a plot showing the fitness score of most fit ant in each
    % generation
        hf = figure(1); set(hf,'Color',[1 1 1]);
        hp = plot(1:Ngen,100*fitness_data/89,'r');
        set(hp,'LineWidth',2);
        axis([0 Ngen 0 100]); grid on;
        xlabel('Generation number');
        ylabel('Ant fitness [%]');
        title('Ant fitness as a function of generation');

    %% Trail 
    % Output a plot showing the trail of the most-fit ant in the final
    % generation
        % read the John Moir Trail (world)
        filename_world = 'muir_world.txt';
        world_grid = dlmread(filename_world,' ');

        % display the John Moir Trail (world)
        world_grid = rot90(rot90(rot90(world_grid)));
        xmax = size(world_grid,2);
        ymax = size(world_grid,1);
        hf = figure(2); set(hf,'Color',[1 1 1]);
        for y=1:ymax
            for x=1:xmax
                if(world_grid(x,y) == 1)
                    h1 = plot(x,y,'sk');
                    hold on
                end
            end
        end
        grid on
        % display the fittest Individual trail
        for k=1:size(trail,1)
            h2 = plot(trail(k,2),33-trail(k,1),'*m');
            hold on
        end
        axis([1 32 1 32])
        title_str = sprintf('John Muri Trail - Hero Ant fitness %d%% in %d generation ',uint8(100*best_fitness/89), Ngen);
        title(title_str)
        lh = legend([h1 h2],'Food cell','Ant movement');
        set(lh,'Location','SouthEast');
