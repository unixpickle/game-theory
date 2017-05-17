% Similar to simulation 2, except that price is quantized
% and there are special rules for equal prices.

global a b c;
a = 50;
c = 2;
b = 1;

function [price] = price_for_demand(qty)
  global a b;
  price = a - b*qty;
end

function [qty] = demand_for_price(price)
  global a b;
  % p = a - b*q
  % => q = (a - p) / b
  qty = (a - price) / b;
  if qty < 0
    qty = 0;
  end
end

function [costs] = production_costs(quantities)
  global c;
  costs = c * quantities;
end

function [sold_quantities] = joint_demand(prices, quantities)
  % Player 1 is the one with a lower price.
  if prices(2) < prices(1)
    sold_quantities = flipud(joint_demand(flipud(prices), flipud(quantities)));
    return
  elseif prices(2) == prices(1)
    % Split sold quantities in proportion to production.
    q = demand_for_price(prices(1));
    frac_1 = quantities(1) / sum(quantities);
    sold_quantities = min(q * [frac_1; 1-frac_1], quantities);
    return
  end

  % Use an undercutting model, which differs from the
  % one in simulation_1.
  % This model is harsher for the player with the
  % higher price.
  sold_quantities = [
    min(demand_for_price(prices(1)), quantities(1));
    0;
  ];

  leftover = demand_for_price(prices(2)) - sold_quantities(1);
  if leftover > 0
    sold_quantities(2) = min(leftover, quantities(2));
  end
end

function [profit] = payoffs(prices, quantities)
  sold_quantities = joint_demand(prices, quantities);
  expenses = production_costs(quantities);
  revenue = sold_quantities .* prices;
  profit = revenue - expenses;
end

function [new_prices, new_quantities] = optimize_player(prices, quantities)
  global a;

  idx = round(rand()) + 1;
  old_u = payoffs(prices, quantities)(idx);
  new_u = old_u;

  new_prices = prices;
  new_quantities = quantities;

  new_prices(idx) = round(rand()*price_for_demand(0));
  new_quantities(idx) = rand()*demand_for_price(0);

  new_u = payoffs(new_prices, new_quantities)(idx);

  if new_u <= old_u
    new_prices = prices;
    new_quantities = quantities;
  end
end

prices = round(rand(2, 1) * 10);
quantities = rand(2, 1)*10;

% Test with a Nash Equilibrium in the real game...
%     prices = price_for_demand(16+16) * [1; 1];
%     quantities = [16; 16];

for i=1:300000
  [prices, quantities] = optimize_player(prices, quantities)
end

prices
quantities
