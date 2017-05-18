% Simulation to find Nash Equilibrium in differentiated
% products game.
%
% This simulation doesn't quite converge, but it clearly
% gets very close to an equilibrium.
% It probably does not converge because the population and
% prices are quantized.
%
% Observations: with t=0, the price converges to 2 (=c).
% With t=5, the price converges to ~7.1.
% Clearly, product differentiation drives up the prices.

global c t;

% Marginal cost of production.
c = 2;

% Importance of product differentiation.
t = 5;

% Prices and quantities are Nx2.
function [quantities] = demand(prices)
  global t;

  [rows, cols] = size(prices);
  quantities = zeros(rows, cols);
  for preference=0:0.01:1
    dists = t * [preference^2 (1-preference)^2];
    total_costs = prices + dists;
    quantities(:,1) += (total_costs(:,1) < total_costs(:,2));
    quantities(:,2) += (total_costs(:,1) > total_costs(:,2));
    quantities += 0.5 * (total_costs(:,1) == total_costs(:,2));
  end
end

function [new_prices] = respond(prices)
  global c;

  idx = round(rand()) + 1;
  price_options = [0:0.01:30];
  price_batch = zeros(prod(size(price_options)), 2);
  price_batch(:,idx) = price_options;
  price_batch(:,3-idx) = prices(1,3-idx);
  quantity_batch = demand(price_batch);

  profits = quantity_batch(:,idx) .* (price_options' - c);
  [max_prof, max_idx] = max(profits);
  new_prices = prices;
  new_prices(1,idx) = price_options(1,max_idx);
end

prices = rand(1,2);
num_samples = 1000;
records = zeros(num_samples, 2);
for i=1:num_samples
  prices = respond(prices);
  records(i,:) = prices;
end

tail_size = round(num_samples*0.1);
last_few = records((num_samples-tail_size):num_samples, :);
mean(last_few)
