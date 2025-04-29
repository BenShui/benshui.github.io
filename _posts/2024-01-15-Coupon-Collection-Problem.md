---
title: 'Coupon Collection Problem'
date: 2024-01-15
permalink: /posts/2024/01/Coupon-Collection-Problem/
tags:
  - interesting problems
  - stochastic process
---

Now consider the following problem: If each box of a given product contains a coupon, and there are $n$ different types of coupons, what is the expected number of boxes that you have to buy in order to collect all types of coupons?

Suppose that all types of coupon are evenly distributed. Let time $T$ be the number of draws needed to collect all $n$ coupons, and let $t_i$ be the time to collect the $i$-th coupon after $i-1$ coupons have been collected. Then we have
$$T=t_1+t_2+\cdots+t_n$$
The probability of collecting a new coupon is given by
$$q_i=\frac{n-(i-1)}{n}=\frac{n-i+1}{n}$$
Therefore, $t_i$ is geometric distribution with expectation 
$$\frac{1}{q_i}=\frac{n}{n-i+1}$$
Finally
$$\mathbb{E}[T]=\sum_{i=1}^{n}\mathbb{E}[t_i]=n\sum_{i=1}^{n}\frac{1}{i}=nH_n$$
where $H_n$ is the $n$-th harmonic number. And it has following asymptotics:
$$\mathbb{E}[T]=n\log n+\gamma n+\frac{1}[2}+O\left(\frac{1}{n}\right)$$
where $\gamma\approx0.5772$ is the Euler constant.

There is a much general solution to this problem. Now, what if the distribution is nonuniform? What if we want to calculate the expected time to collect 2 coupon 1 and 1 coupon 2?

A kind of shocking solution to this is one can embed this into a continuous time Poisson process. Now denote $p_i$ as the probability of collecting the $i$-th coupon. The final goal is to collect $k_i$ amount of type $i$ coupons. Consider the collector collects the coupons in accordance to a Poisson process with rate $\lambda=1$. Define stopping time
$$T_i=\inf\{t\in\mathbb{R}_+: \text{collecting }k_i\text{ coupon }i\}$$
and then
$$T:=\max_{1\leq i\leq n}T_i$$
Our goal is to calculate $\mathbb{E}[T]$ now. By Tail Sum formula
$$\mathbb{E}[T]=\int_0^{\infty}(1-\mathbb{P}(T\leq t))\mathrm{d}t=\int_0^{\infty}(1-\mathbb{P}(T_i\leq t,\forall 1\leq i\leq n)\mathrm{d}t$$
Note that $T_i$ are independent. Hence
$$\mathbb{E}[T]=\int_0^{\infty}\left(1-\prod_{i=1}^{n}\mathbb{P}(T_i\leq t)\right)\mathrm{d}t$$
The probability can be expressed explicitly as
$$\mathbb{P}(T_i\leq t)=1-\sum_{k=0}^{k_i-1}e^{-p_it}\frac{(p_it)^k}{k!}$$



### Reference
+ Flajolet, Philippe; Gardy, Danièle; Thimonier, Loÿs (1992), "Birthday paradox, coupon collectors, caching algorithms and self-organizing search", Discrete Applied Mathematics, 39 (3): 207–229, CiteSeerX 10.1.1.217.5965, doi:10.1016/0166-218x(92)90177-c