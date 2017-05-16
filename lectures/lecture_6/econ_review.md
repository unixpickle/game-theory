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

## Only one price?

As professor Polak presents it, `p` is the same for firm 1 and firm 2. Why is this a valid model? After all, the firms really get to decide both price *and* quantity. In perfect competition, we said that firms could not choose their own prices because they would keep trying to undercut each other. In a Cournot duopoly, we must revise our assumptions.

In a duopoly, the prices might end up being higher than the marginal cost. Suppose two firms produce quantities `q1` and `q2` and charge prices `p1` and `p2`. If `p1 < p2`, then firm 1 will indeed sell all of its product before firm 2 sells any of its product. However, there might still be left-over demand after `q1` has been used up, and now consumers will start to buy from firm 2. If that happens, then firm 2 might actually make more profit than firm 1 even though `p2 > p1`. Thus, the undercutting argument for perfect competition fails for duopoly.

Even though the perfect competition assumption fails, there is still some equilibrium price that both firms in a duopoly will share. If firm 1 charges less than firm 2, then there are two cases, both of which move the prices closer to an equilibrium:

 * Firm 2 has some revenue: firm 1 should raise its price, since there is clearly residual demand for the product.
 * Firm 2 has no revenue: firm 2 should lower its price to get in on some of firm 1's profit.

Ultimately, the price will arrive at some equilibrium point which is determined by the quantities produced. Suppose the firms choose their quantities, giving `q1+q2`. If they charge less than `a - b*(q1+q2)`, then they are throwing money away since they could sell the same quantity for a higher price. If they charge more than `a - b*(q1+q2)`, then they are throwing product away and could have produced less.
