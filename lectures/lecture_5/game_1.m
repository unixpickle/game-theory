% Finds NE (3,3) for the first game in lecture.

payoffs = [0 4 5; 4 0 5; 3 3 6];
payoffs(:,:,2) = [4 0 3; 0 4 3; 5 5 6];

for i=1:3
  for j=1:3
    row_payoffs = payoffs(:, j, 1);
    col_payoffs = payoffs(i, :, 2);
    row_best = all(row_payoffs(i) >= row_payoffs);
    col_best = all(col_payoffs(j) >= col_payoffs);
    if row_best && col_best
      [i, j]
    end
  end
end
