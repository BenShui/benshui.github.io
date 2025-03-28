---
title: 'Perfect Bayesian Nash Equilibrium'
date: 2025-03-28
permalink: /posts/2025/03/Perfect-Bayesian-NE/
tags:
  - Game Theory
---

In the winter of 2025, I took my first Game Theory course. However, some of the topics were quite obscure, and due to time constraints, I didn’t fully grasp them. In particular, Perfect Bayesian Nash Equilibrium involves a belief system. For future reference, I will write rigorous notes on this topic during my first year.

**The Notes on PBE will be posted here** [To be completed]

Question on Winter Final:

Consider a job-market signaling game with nature, a worker called player 1, and a firm
called player 2. Play proceeds as follows in order:

+ Nature chooses player 1’s ability level $a\in \{H,L\}$ and player 1’s signal $\gamma\in\{G,B\}$, according to the following probability distribution:
  + $(a, \gamma) = (H, G)$ with probability $1/3$ 
  + $(a, \gamma) = (H, B)$ with probability $1/6$ 
  + $(a, \gamma) = (L, G)$ with probability $1/6$ 
  + $(a, \gamma) = (L, B)$ with probability $1/3$

  This distribution can be thought of as the result of a two-stage lottery, where nature first chooses $a$ with equal probability on $H$ and $L$, and then conditional on $a$, nature chooses $\gamma$ with accuracy probability $2/3$.
+ Player 1 observes $\gamma$, so we call $\gamma$ player 1’s type. Player 1 does not observe $a$. Player 1 then chooses an education level $x \in {0, 1}$ at personal cost $x$.
+ Player 2 observes player 1’s choice of $x$ and nothing else. Then player 2 chooses whether to hire player 1 for a managerial position (action $m$), hire player 1 to a clerical position (action $c$), or not hire player 1 (action $n$). The game then ends.

Payoffs are specified as follows:

+ If player 2 chooses action $n$ (not hiring player 1), then player 1’s payoff is $-x$ and player 2’s payoff is $0$. 
+ If player 2 chooses action $c$ (hiring to the clerical position), then player 1’s payoff is $2 - x$, and player 2’s payoff is $3$ in the event of $a = H$ and $-1$ in the event of $a = L$. 
+ If player 2 chooses action $m$ (hiring to the managerial position), then in the event of $a = H$, player 1’s payoff is $4 - x$ and player 2’s payoff is $5$; and in the event of $a = L$, player 1’s payoff is $2 - x$ and player 2’s payoff is $-4$.

(a) Suppose that player 1 has a belief about $a$ that puts probability $q$ on $a = H$ and probability $1 - q$ on $a = L$. As a function of $q$, what is player 1’s expected payoff of being hired to the managerial job (player 2’s action $m$), for whatever $x$ she chooses?

(b) Suppose that player 2 has a belief about $a$ that puts probability $q$ on $a = H$ and probability $1 - q$ on $a = L$. As a function of $q$, what are player 2’s expected payoffs of choosing $n$, choosing $c$, and choosing $m$?

(c) Fully describe a separating perfect Bayesian equilibrium in which player 1’s type $G$ chooses $x = 1$ and player 1’s type $B$ chooses $x = 0$. Assume minimal consistency. (Because both of player 2’s situations are reached with strictly positive probability in such an equilibrium, the conditions for minimal consistency are the same as for stronger consistency notions.) Be sure to include the beliefs at player 2’s two situations, in either appraisal or assessment form.

(d) Is there a pooling sequential equilibrium in which both types of player 1 choose $x = 0$? If so, fully describe such an equilibrium, and be sure to describe the sequence of fully mixed behavior strategies for player 1 from which player 2’s beliefs are derived and which converges to player 1’s equilibrium strategy.

(e) Does this game have a Bayesian Nash equilibrium in which both types of player 1 choose $x = 1$? If so, name the equilibrium strategy profile. Can you add beliefs to create a perfect Bayesian equilibrium? If so, explain whether these beliefs satisfy the requirements of full consistency or plain consistency.

