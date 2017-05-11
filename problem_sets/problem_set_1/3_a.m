% Problem 3a: find strategies that dominate 1.
%
% Answer: strategies 2-7 dominate strategy 1.

% Build row player's payoff matrix.
payoffs = zeros(10, 10);
for i=1:10
  for j=1:10
    vote_pct = 0;
    for k=1:10
      dist_i = abs(i-k);
      dist_j = abs(j-k);
      if dist_i < dist_j
        vote_pct += 10;
      elseif dist_i == dist_j
        vote_pct += 5;
      end
    end
    payoffs(i,j) = vote_pct;
  end
end

for i=2:10
  if all(payoffs(i,:) > payoffs(1,:))
    i
  end
end
