% Duopoly simulation where firms pick both prices and
% quantities simultaneously.
%
% This model assumes that demand can be divided, even when
% there are two prices on the market.
% In particular, it assumes that the cheapest consumers
% make their purchases first, then the ones willing to pay
% more end up paying more.
%
% Turns out, the Nash Equilibrium I found in the duopoly
% game of (16, 16) is not a Nash Equilibrium in this
% simulation.
% I need better intuition for why both firms have to
% charge the same prices, because this simulation makes
% it seem like each first would strategically raise or
% lower its price relative to the other firm's.

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
  end

  % Use the undercutting model, where player 1 gets as
  % much demand as possible and then player 2 gets as
  % much demand at his higher price as is possible.
  sold_quantities = [
    min(demand_for_price(prices(1)), quantities(1));
    demand_for_price(prices(2));
  ];
  one_only = demand_for_price(prices(1)) - demand_for_price(prices(2));
  if sold_quantities(1) > one_only
    stolen = sold_quantities(1) - one_only;
    sold_quantities(2) -= stolen;
  end
  sold_quantities = min(sold_quantities, quantities);
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

  new_prices(idx) = rand()*price_for_demand(0);
  new_quantities(idx) = rand()*demand_for_price(0);

  new_u = payoffs(new_prices, new_quantities)(idx);

  if new_u <= old_u
    new_prices = prices;
    new_quantities = quantities;
  end
end

prices = rand(2, 1) + 10;
quantities = rand(2, 1) + 10;

% Test with a Nash Equilibrium in the real game...
%     prices = price_for_demand(16+16) * [1; 1];
%     quantities = [16; 16];

for i=1:300000
  [prices, quantities] = optimize_player(prices, quantities)
end

prices
quantities
