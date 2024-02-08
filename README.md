In this project we use Genetic Algorithm to build a better ant through evolution.
Each ant must survive on its own in a world represented by a 2D grid of cells by following trails of food.
The fitness of the ant is rated by counting how many food elements it consumes in 200 time-steps.
The controller for our ant will consist of a 10-state finite state machine (FSM).
The ant's orientation takes values 1, 2, 3, 4 representing east, north, west, south respectively.

The implementation is done in MATLAB 2020a/later versions.
The algorithm makes use of appropriate crossover and mutation operators:
  
Design decisions on how to implement the algorithm and what
parameter values to use.
