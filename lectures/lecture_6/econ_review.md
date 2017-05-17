# Microeconomics Review

I paused the video at 27:10 to see if I could re-derive some basic results from microeconomics. To review the setup, we have:

 * 2 firms with strategies `q1` and `q2`.
 * Constant marginal cost of production: `c`
 * Demand curve: `p = a - b*(q1+q2)`
 * Payoff (profit): `u1(q1, q2) = p*q1 - c*q1`

## Demand curve

Let's review what the demand curve actually models.

For the sake of explanation, assume that each person only wants one item, and different people are willing to pay different amounts for that item. As the price gets lower and lower, more and more people will be able to afford the item. Thus, there is an inverse relationship between q (quantity consumed) and p (price paid by consumers).

## Perfect competition

In perfect competition, each firm will try to lower their price to undercut the other firm. This happens until the price `p` is equal to the marginal cost `c`. At this point, a firm cannot lower its prices any further without losing money. Since the marginal cost is constant in this example, the supply curve is a horizontal line at `p=c`.

In the above situation, perfect competition would give

```
c = p
  = a - b*(q1+q2)

=> q1+q2 = (a-c)/b
```

Notice that the above equation only makes sense if `a >= c`. Intuitively, if `a < c`, it costs more to make a single item than any consumer is willing to pay for that item.

## Cournot model

In the perfect competition model, we assume that firms compete in prices. In a Cournot model, we instead assume that firms choose their quantities and let the market determine the price. This might seem odd or arbitrary, but it makes sense if we assume that output is much more difficult to change than price. Under this assumption, firms are really playing a two step game: first they choose quantity (slow), then they choose price (fast). In the second game, once quantities are fixed, price competition will bring the firms down to a price determined by the market. This can probably be shown via iterative deletion in the price game (with fixed quantities).

It is clear why hard-to-change quantities would make the market less Pareto efficient than perfect competition. Suppose that two firms are both producing at the perfect competition equilibrium. If quantities were easy to change, then neither firm can raise its price. If firm 1 does raise its price, then firm 2 will simply increase its output and completely steal firm 1's revenue. However, if quantities are hard to change, then firm 2 cannot increase its output and firm 1 will still sell to some consumers at the higher price (albeit in lower quantities).
