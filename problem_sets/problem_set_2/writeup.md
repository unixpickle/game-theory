# Note

There is no guarantee that these solutions are correct. These are simply my attempts at solving the problems on paper. I may attempt to verify some of these answers programmatically.

# 1. Penalty Shots Revisited

## Part a

There are no dominated strategies.

## Part b

By solving an inequality, we can find that player 2's best response is *m* if and only if

```
6*max(P(R),P(L)) + 1*min(P(R),P(L)) <= 3
```

In the case where `P(R) = P(L)`, this means

```
P(R) <= 3/7
```

By solving a similar inequality, we can find a system of inequalities for when player 1's best response is *M*:

```
6*(p(l) + p(r)) >= 9*p(l) + 4*p(r)
6*(p(l) + p(r)) >= 4*p(l) + 9*p(r)
```

By adding the two equations together and dividing by 2, we get the following inequality:

```
6*(p(l) + p(r)) >= 6.5*(p(l) + p(r))
```

Thus, *M* is never a best response.

## Part c

Player 1 will never play M. Thus, `P(R) + P(L) = 1`. The first inequality for part b can never be satisfied if `P(M) < 1/7`, so player 2 should never play m. The game is left to L, R, l, r.

## Part d

This is trivial to see by filling in the table with best responses. Intuitively, it makes sense: the goalie always wants to follow the shooter and the shooter always wants to avoid the goalie.

# 2. Partnerships Revisited

## Part a

We want to maximize

```
4*(2s+bs^2) - 2s^2
```

Setting the derivative equal to zero, we find

```
s = 2/(1-2b)
```

When `b=1/4`, the optimal effort is 4. When `b=0`, the optimal effort is 2. These are higher than the rationalizable effort levels. Why? Because the contract forces each player not to free-ride off the other one.

## Part b

Partner 1's choice will be `BR1(s**)`. This is equal to `1+2b/(1-2b)`. If `b=1/4`, then this best response is 2. Intuitively, player 1's best option is to reduce his effort since he will only lose half the profits but gain back all of his time.

## Part c

Best response functions are the same, namely `BR1(s2) = 1 + b*s2 = 1 - s2/2`. The only rationalizable strategy is 2/3, since that satisfies `1 - s/2 = s`. At this point, `u1(s1, s2) = 1.777`.

In the case of the contract, the optimal case is `2/(1-2b) = 1`. At this point, `u1(s1, s2) = 2`.

# 3. NE and Iterative Deletion

## Part a

D is strictly dominated by T. After deleting D, C is strictly dominated by R. Thus, we are left with T, M, L, R.

## Part b

NE's are (M, L) and (T, R).

## Part c

Say we have a NE, where `s[i]` is a BR to `s[-i]` and vice versa. Then `s[i]` is not strictly dominated because it is a best response, and likewise nothing in `s[-i]` is strictly dominated. Thus, we cannot delete the NE strategies. Further, if we delete some other strategy, then `s[i]` remains a BR to `s[-i]` (and vice versa) because no *better responses* could have been added. Thus, the NE remains an NE in the reduced game.

# 4. Splitting the dollar

## Part a

All pairs `(x,y)` where `x+y=10` are NEs. Further, the pair `(10,10)` is an NE.

Any other pair `(x,y)` where `x+y>10` is not an NE since one player can reduce their value to 10 minus the other player's value. Any pair `(x,y)` where `x+y<10` is not an NE since either player could increase their value and get more money.

## Part b

The point `(5,5)` is the only NE.

All values less than 5 are strictly dominated, because you can always make $5 by playing the same number as the other player. Also, one player is playing something greater than 5, then the other player can undercut them and get more than $5.

## Part c

By using whole numbers, the game in part b gets another NE, namely `(6,6)`. This is because neither player can undercut 6 without playing 5, and playing 5 won't get them more money than they were already getting anyway.
