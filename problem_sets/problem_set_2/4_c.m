% Solve problem 4c by finding Nash Equilibria in two
% related games.

function [u1, u2] = payoff(gameIdx, s1, s2)
  if gameIdx == 1
    if s1 + s2 > 10
      u1 = 0;
      u2 = 0;
    else
      u1 = s1;
      u2 = s2;
    end
  else
    if s1 + s2 > 10
      if s1 > s2
        u1 = 10 - s2;
        u2 = s2;
      elseif s1 < s2
        u1 = s1;
        u2 = 10 - s1;
      else
        u1 = 5;
        u2 = 5;
      end
    else
      u1 = s1;
      u2 = s2;
    end
  end
end

for game=1:2
  game
  % Indices: s1, s2, player index
  board = zeros(11, 11, 2);
  for s1=0:10
    for s2=0:10
      [u1, u2] = payoff(game, s1, s2);
      board(s1+1, s2+1, :) = [u1 u2];
    end
  end

  for s1=1:11
    for s2=1:11
      s1_options = board(:, s2, 1);
      s2_options = board(s1, :, 2);
      s1_br = all(s1_options(s1) >= s1_options);
      s2_br = all(s2_options(s2) >= s2_options);
      if s1_br && s2_br
        [(s1-1) (s2-1)]
      end
    end
  end
end
