% Duopoly simulation where firms pick both prices and
% quantities simultaneously.
%
% This model assumes that demand can be divided, even when
% there are two different prices on the market.

global a b c;
a = 50;
c = 2;
b = 1;

% If true, then the consumers willing to pay the most will
% buy from the firm with the higher price.
% If false, then the consumers willing to pay the most buy
% from the firm with the lower price, thus leaving less
% business for the firm with the higher price.
optimistic_divide = false;

% If true, then prices are whole numbers.
discrete_price = false;

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

function [price] = random_price()
  global discrete_price;
  price = rand()*price_for_demand(0);
  if discrete_price
    price = round(price);
  end
end

function [qty] = random_quantity()
  qty = rand()*demand_for_price(0);
end

function [sold_quantities] = joint_demand(prices, quantities)
  global optimistic_divide discrete_price;

  % Make player 1 have the lower price.
  if prices(2) < prices(1)
    sold_quantities = flipud(joint_demand(flipud(prices), flipud(quantities)));
    return
  end

  % Special rule when nobody is undercutting.
  if discrete_price && prices(2) == prices(1)
    % Split sold quantities in proportion to production.
    q = demand_for_price(prices(1));
    frac_1 = quantities(1) / sum(quantities);
    sold_quantities = min(q * [frac_1; 1-frac_1], quantities);
    return
  end

  if optimistic_divide
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
  else
    sold_quantities = [
      min(demand_for_price(prices(1)), quantities(1));
      0;
    ];

    leftover = demand_for_price(prices(2)) - sold_quantities(1);
    if leftover > 0
      sold_quantities(2) = min(leftover, quantities(2));
    end
  end
end

function [profit] = payoffs(prices, quantities)
  sold_quantities = joint_demand(prices, quantities);
  expenses = production_costs(quantities);
  revenue = sold_quantities .* prices;
  profit = revenue - expenses;
end

function [new_prices, new_quantities] = optimize_player(prices, quantities)
  global discrete_price;

  idx = round(rand()) + 1;
  old_u = payoffs(prices, quantities)(idx);
  new_u = old_u;

  new_prices = prices;
  new_quantities = quantities;

  new_prices(idx) = rand()*price_for_demand(0);
  if discrete_price
    new_prices(idx) = round(new_prices(idx));
  end
  new_quantities(idx) = rand()*demand_for_price(0);

  new_u = payoffs(new_prices, new_quantities)(idx);

  if new_u <= old_u
    new_prices = prices;
    new_quantities = quantities;
  end
end

prices = [random_price(); random_price()];
quantities = [random_quantity(); random_quantity()];

% Test with a Nash Equilibrium in the Cournot game...
%     prices = price_for_demand(16+16) * [1; 1];
%     quantities = [16; 16];

num_runs = 10000;
quantity_history = zeros(num_runs, 2);
price_history = zeros(num_runs, 2);
for i=1:num_runs
  [prices, quantities] = optimize_player(prices, quantities);
  quantity_history(i, :) = quantities';
  price_history(i, :) = prices';
end

mean_prices = mean(price_history)
mean_quantities = mean(quantity_history)
