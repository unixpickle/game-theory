% Problem 4a: find dominated strategies.
%
% Answer: for player 1, voting for a preferable winner
% dominates voting for a less-preferable one.
% For players 2 and 3, the least preferable winner is
% dominated by the most preferable winner.
%
% Output: matrices for each player indicating dominated
% strategies.
% In particular, if the row strategy is dominated by the
% column strategy, then the entry is 1 (or 2 for strict).

% 0 for undominated, 1 for weakly, 2 for strongly.
function [domAmount] = dominated(badStrat, goodStrat)
  gt = goodStrat > badStrat;
  ge = goodStrat >= badStrat;
  domAmount = 0;
  domAmount += (all(all(ge)) && any(any(gt)));
  domAmount += all(all(gt));
end

% Row i = player i's reward for for a,b,c.
% These are made up payoffs.
% 2 just represents first preference, 1 second preference,
% 0 third preference.
rankings = [2 1 0; 1 0 2; 0 2 1];

% Indices: [1 action, 2 action, 3 action, player].
payoffs = zeros(3, 3, 3, 3);
for i=1:3
  for j=1:3
    for k=1:3
      winner = mode([i j k]);
      if i ~= j && i ~= k && j ~= k
        winner = i;
      end
      payoffs(i,j,k,:) = rankings(:,winner);
    end
  end
end

for player=1:3
  comps = zeros(3,3);
  for act1=1:3
    for act2=1:3
      p1 = payoffs(act1,:,:,:);
      p2 = payoffs(act2,:,:,:);
      if player == 2
        p1 = payoffs(:,act1,:,:);
        p2 = payoffs(:,act2,:,:);
      elseif player == 3
        p1 = payoffs(:,:,act1,:);
        p2 = payoffs(:,:,act2,:);
      end
      comps(act1, act2) = dominated(p1(:,:,:,player), p2(:,:,:,player));
    end
  end
  player
  comps
end
