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

My understanding of this model is that it is a two-step game. First, the firms decide how much to produce. After that production, they play another game to decide their prices. I have yet to figure out how, but I suspect you can use this two-step model to explain why the prices are determined by the free market.
