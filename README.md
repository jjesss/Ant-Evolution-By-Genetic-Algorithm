In this project I used Genetic Algorithm to build a better ant through evolution.
Each ant must survive on its own in a world represented by a 2D grid of cells by following trails of food.
The fitness of the ant is rated by counting how many food elements it consumes in 200 time-steps.
The controller for our ant will consist of a 10-state finite state machine (FSM).
The ant's orientation takes values 1, 2, 3, 4 representing east, north, west, south respectively.

The implementation is done in MATLAB 2020a/later versions.
The user is asked to select a method of selection, crossover and mutation.
Where the options are:
  Selection:
    1. Roulette Selection
    2. Tournament Selection
    3. Linear Rank Selection

  Crossover:
    1. K-Point Crossover
    2. Uniform Crossover

  Mutations:
    1. Mutation with value encoding
    2. Insertion Mutation
    
The genetic algorithm has two end strategy conditions where it will stop when either the max number of 1000 generations are produced or when the average fitness value of the population remains fixed for several intervals.

