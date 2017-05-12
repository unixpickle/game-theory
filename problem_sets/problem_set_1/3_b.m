% Problem 3b: in 3-player game, is 1 dominated by 2 or 3?
% Also, if we delete 1 & 10, is 2 dominated?
%
% Answer: 2 and 3 weakly dominate 1. Nothing else does.
% Also, after deletion, no strategies dominate 2.

% Build first-dimension's payoff tensor.
payoffs = zeros(10, 10, 10);
for i=1:10
  for j=1:10
    for k=1:10
      vote_pct = 0;
      for voter=1:10
        dist_i = abs(i-voter);
        dist_j = abs(j-voter);
        dist_k = abs(k-voter);
        if dist_i <= dist_j && dist_i <= dist_k
          numWinners = 1 + sum([dist_j dist_k] == dist_i);
          vote_pct += 10 / numWinners;
        end
      end
      payoffs(i,j,k) = vote_pct;
    end
  end
end

for i=2:3
  i
  strict_dom = all(all(payoffs(i,:,:) > payoffs(1,:,:)))
  weak_dom = all(all(payoffs(i,:,:) >= payoffs(1,:,:)))
end

% Delete strategies 1 and 10.
payoffs = payoffs(2:9,2:9,2:9);

printf('\n\nTrying on reduced game...\n\n');

for i=2:8
  i
  strict_dom = all(all(payoffs(i,:,:) > payoffs(1,:,:)))
  weak_dom = all(all(payoffs(i,:,:) >= payoffs(1,:,:)))
end
