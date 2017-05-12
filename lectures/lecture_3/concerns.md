# Doubts about iterative deletion

At this point, I have some doubts about iterative deletion. My doubts go back to the first lesson from lecture 1: *never play a dominated strategy*. That made sense in lecture 1 when we weren't thinking back and forth about our opponent's thought process. However, now that our opponent is trying to predict what we will do, maybe picking a dominated strategy might help us on average?

Here is a game to demonstrate my doubts. We are the row player, and the enemy is the column player:

|         | C      | D        |
|---------|--------|----------|
| A       | 1000,5 | 10,10    |
| B       | 0,5    | 0,-10000 |

Notice that strategy B is strictly dominated by strategy A. Thus, if we were rational, we would play A. Knowing of our rationality, the enemy would exclude the possibility of us playing B. Thus, he would play D, since that dominates C when we play A. In the end, **our payoff would be 10**.

Now suppose that we sometimes act irrationally. Specifically, suppose we always flip a coin and use that to decide which action we take. With 1/2 probability, we will choose B. Knowing this, the enemy cannot reasonably play D, since that would yield a whopping -4995 payoff on average. Having forced our enemy to play C, **we will get an expected payoff of 500**, since we will play A half the time.

It should be noted that, in the above example, our random strategy would make no sense if the game was played only once. If the game was truly played only once, and our coin told us to play B, we shouldn't listen to it. The *only* benefit of picking B is that the risk of B forces the enemy to do something in our favor. Essentially, the threat of hurting ourselves benefits us on average.

I looked through the lectures and saw the mention of a "credible threat". Perhaps what I suggested above is an example. I am excited to find out.
