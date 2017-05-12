// I paused the lecture at time 38:13 to see if I could
// figure out a way to solve the problem on my own.
//
// Problem description: two players, actions in [0, 4].
// Profit = 4*(s1 + s2 + b*s1*s2) where b in [0, 1/4].
// Payoff for player i is 1/2*profit + s_i^2
//
// I decided to try using gradient descent to iteratively
// modify each player's strategy distribution.
//
// The output of the program suggests that the amount of
// effort put in increases as b increases.
// However, this the output is less conclusive when we
// start with a random initialization.

package main

import (
	"fmt"
	"math"
	"math/rand"
	"time"

	"github.com/unixpickle/anydiff"
	"github.com/unixpickle/anyvec"
	"github.com/unixpickle/anyvec/anyvec64"
)

const (
	// We discretize the strategies into bins.
	NumStrategies = 64

	// We may want to start with a randomized strategy.
	RandomInit = false

	// Affects rate of SGD convergence.
	StepSize = 0.1
)

var Creator = anyvec64.CurrentCreator()

func main() {
	if RandomInit {
		rand.Seed(time.Now().UnixNano())
	}

	for beta := 0.0; beta < 0.25; beta += 0.025 {
		// Softmax parameters for both players.
		params1 := anydiff.NewVar(Creator.MakeVector(NumStrategies))
		params2 := anydiff.NewVar(Creator.MakeVector(NumStrategies))

		if RandomInit {
			anyvec.Rand(params1.Vector, anyvec.Normal, nil)
			anyvec.Rand(params2.Vector, anyvec.Normal, nil)
		}

		payoffs := rowPayoffMatrix(beta)
		for i := 0; i < 20000; i++ {
			for i := 0; i < 2; i++ {
				pay := expectedPayoff(payoffs, params1, params2)
				grad := anydiff.NewGrad(params1)
				pay.Propagate(oneVec(), grad)
				grad.Scale(StepSize)
				grad.AddToVars()
				params1, params2 = params2, params1
			}
		}

		pay1 := expectedPayoff(payoffs, params1, params2)
		pay2 := expectedPayoff(payoffs, params2, params1)
		fmt.Printf("beta=%f pay1=%f pay2=%f act_1=%s act_2=%s\n",
			beta, anyvec.Sum(pay1.Output()), anyvec.Sum(pay2.Output()),
			maxActionDesc(params1), maxActionDesc(params2))
	}
}

func expectedPayoff(payoffMat anyvec.Vector, params1, params2 anydiff.Res) anydiff.Res {
	dist1 := anydiff.Exp(anydiff.LogSoftmax(params1, 0))
	dist2 := anydiff.Exp(anydiff.LogSoftmax(params2, 0))
	outcomeProbs := outerProduct(dist1, dist2)
	return anydiff.Sum(anydiff.Dot(outcomeProbs.Data, anydiff.NewConst(payoffMat)))
}

func rowPayoffMatrix(beta float64) anyvec.Vector {
	strat := func(i int) float64 {
		return 4 * float64(i) / float64(NumStrategies-1)
	}
	var matData []float64
	for row := 0; row < NumStrategies; row++ {
		for col := 0; col < NumStrategies; col++ {
			profit := 4 * (strat(row) + strat(col) + beta*strat(row)*strat(col))
			payoff := 0.5*profit - math.Pow(strat(row), 2)
			matData = append(matData, payoff)
		}
	}
	return Creator.MakeVectorData(Creator.MakeNumericList(matData))
}

func maxActionDesc(params anydiff.Res) string {
	maxIdx := anyvec.MaxIndex(params.Output())
	strat := 4 * float64(maxIdx) / float64(NumStrategies-1)
	prob := anydiff.Exp(anydiff.LogSoftmax(params, 0)).Output().Slice(maxIdx, maxIdx+1)
	return fmt.Sprintf("%f(prob=%f)", strat, anyvec.Sum(prob))
}

func outerProduct(v1, v2 anydiff.Res) *anydiff.Matrix {
	m1 := &anydiff.Matrix{Data: v1, Rows: v1.Output().Len(), Cols: 1}
	m2 := &anydiff.Matrix{Data: v2, Rows: 1, Cols: v2.Output().Len()}
	return anydiff.MatMul(false, false, m1, m2)
}

func oneVec() anyvec.Vector {
	return Creator.MakeVectorData(Creator.MakeNumericList([]float64{1}))
}
