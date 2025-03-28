% this is simulator for ant

function [fitness, trail] = simulate_ant(world_grid, string_controller)

[r_world_grid, c_world_grid] = size(world_grid);

% parse string into fsm
fsm_controller = zeros(10,3);
for i=1:10
    for j=1:3
        % puts string controller into 10x3 matrix 
        fsm_controller(i,j) = string_controller((i-1)*3+j);
    end
end

fitness = 0;
trail = zeros(200,2);

ant_pos = [1 1];
ant_ori = 1;
curr_state = 0;
for k=1:200
    % check what is the place itll move to next
    % read gridcell in front and get false/true
    front_pos = ant_pos;
    % facing right
    if (ant_ori == 1)
        % front position is to the right
        front_pos(2) = front_pos(2) + 1;
        % if out of world, it can go other side
        if (front_pos(2) > c_world_grid) front_pos(2) = 1; end
    % facing up
    elseif (ant_ori == 2)
        front_pos(1) = front_pos(1) - 1;
        % jumps to bottom
        if (front_pos(1) == 0) front_pos(1) = r_world_grid; end
    % facing left
    elseif (ant_ori == 3)
        front_pos(2) = front_pos(2) - 1;
        if (front_pos(2) == 0) front_pos(2) = c_world_grid; end
    % facing down
    elseif (ant_ori == 4)
        front_pos(1) = front_pos(1) + 1;
        % jumps top
        if (front_pos(1) > r_world_grid) front_pos(1) = 1; end
    end
    % either 1 or 0
    exist_food = world_grid(front_pos(1), front_pos(2));

    % change currstate
    curr_state = fsm_controller(curr_state+1, exist_food+2);

    % take action
    temp_action = fsm_controller(curr_state+1, 1);
    if (temp_action == 1)
        % move forward one cell
        if (ant_ori == 1)
            ant_pos(2) = ant_pos(2) + 1;
            if (ant_pos(2) > c_world_grid) ant_pos(2) = 1; end
        elseif (ant_ori == 2)
            ant_pos(1) = ant_pos(1) - 1;
            if (ant_pos(1) == 0) ant_pos(1) = r_world_grid; end
        elseif (ant_ori == 3)
            ant_pos(2) = ant_pos(2) - 1;
            if (ant_pos(2) == 0) 
                ant_pos(2) = c_world_grid; end
        elseif (ant_ori == 4)
            ant_pos(1) = ant_pos(1) + 1;
            if (ant_pos(1) > r_world_grid) ant_pos(1) = 1; end
        end
    elseif (temp_action == 2)
        % turn right 90 degrees
        ant_ori = ant_ori - 1;
        if (ant_ori == 0) ant_ori = 4; end
    elseif (temp_action == 3)
        % turn left 90 degrees
        ant_ori = ant_ori + 1;
        if (ant_ori == 5) ant_ori = 1; end
    end

    % possibly eat food and increase fitness, and store trail
    if (world_grid(ant_pos(1), ant_pos(2)) == 1)
        % food is eaten by ant
        world_grid(ant_pos(1), ant_pos(2)) = 0;
        % add one to fitness
        fitness = fitness + 1;
    end
    trail(k,:) = ant_pos;
end
