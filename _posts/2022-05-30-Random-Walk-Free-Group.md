---
title: 'Random Walk on Free Group'
date: 2022-05-30
permalink: /posts/2022/05/Random-Walk-Free-Group/
tags:
  - interesting problems
  - stochastic process
---

Yesterday I found a very interesting problem. It states:

Consider a free group with generators $a$ and $b$. A word comprises a product of symbols, where a symbol is one of $a$, $b$ or their respective inverses, $a^{-1}$ and $b^{-1}$. For example, here is a word with 7 element:

$$a,b,a,b^{-1},a,a^{-1},b$$

Multiplying two words together corresponds to concatenation; for example, the product of $a,b,a,b^{-1},a,a^{-1},b$ is the word displayed above. We denote the empty word 1, this is the identity element for the group. A reduction operation $f$ removes sucessive instances of a symbol and its inverse from a word until no more remain, so $f(1a)=a$ and $f(bb^{-1})=1$. Applying $f$ to the word displayed above, we get

$$f(a,b,a,b^{-1},a,a^{-1},b)=a,b,a$$

Consider the following randomised strategy for generating words. Starting from the empty word $X_0=1$, at each subsequent iteration $n\geq 1$ generate $X_n$ as follows:

Sample $\xi_n\sim\text{Unif}(a,a^{-1},b,b^{-1})$: we select a symbol from the alphabet $a,a^{-1},b,b^{-1}$, choosing each symbol with probability $1/4$.
Set $X_n=f(X_{n-1},\xi_n)$: we multiplty $\xi_n$ on the right of $X_{n-1}$, which corresponds to concatenating $X_{n-1}$ and $\xi_n$, then perform any necessary reduction operations via $f$.

Consider the stochastic process $(X_n:n\geq1)$ defined above.

+ Show that the probability that the empty word ever reoccurs is $1/3$. (Hint: The empty word can only reappear if a word is followed by its inverse, such as $a^{-1},b,a$ followed by $a^{-1},b^{-1},a$, then reduced)
+ Let $g$ denote the function which counts the number of symbols in a word, where the empty word has length $0$. Thus $g(a,a,b)=3$, but $g(1)=0$. Let $Y_n:=g(X_n)$ be the length of word $X_n$. 
  + Calculate $\mathbb{E}[Y_n|Y_{n-1}]$ 
  + Show that $\mathbb{E}[Y_n]=n/2$ 
+ Let $h_y$ denote the probability that $(Y_n:n\geq 1)$ hits $0$ started from $Y_0=y$. We have a single boundary condition, that $h_0=1$. Calculate $h_y$ for $y>0$. 
  + Define the random variable $T:=\inf\{n\geq 1:Y_n=56\}$, the first time the process generates a reduced word of length 56. Derive an expression for $\mathbb{P}(X_T=a,a,a,\cdots,a,b,b,b,b)$, the probability that the word at iteration $T$ is symbol $a$ repeated 52 times followed by $b$ repeated 4 times.