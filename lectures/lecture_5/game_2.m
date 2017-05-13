% Finds NE (2,2) for the second game in lecture.

payoffs = [0 2 4; 11 3 0; 0 1 8];
payoffs(:,:,2) = [2 3 3; 1 2 0; 3 0 0];

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
