% Selection Algorithm. A set of weights represents the probability of selection of each
% chromosome in a group of choices. It returns the index of the chosen chromosome.
% ---------------------------------------------------------
function choice = Roulette(weights)
  % cdf
  accumulation = cumsum(weights);
  p = rand();
  chosen_index = -1;
  
  for index = 1 : length(accumulation)
    % if cdf at index is more than the random number in [0,1]
    if (accumulation(index) > p)
      chosen_index = index;
      break;
    end
  end
  choice = chosen_index;

% selection method : roulette
