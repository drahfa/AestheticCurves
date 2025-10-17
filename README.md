# MATLAB reproduction of Symmetry 12-01394 figures

Run `reproduce_figures` inside MATLAB to regenerate the five plots discussed in
Crăciun et al., *On Approximate Aesthetic Curves* (Symmetry 2020). Figure 5 is
reported as a pair of ε-aesthetic curves and is rendered here via their curvature
functions. Output PNGs are written to the `output/` folder.

---

## Figure 1 – ε-neutral convergent curves (Application 1)
Curvature family (Eq. FD17):

$$
k_p(s) = \frac{1}{1 + p\,s}, \qquad p \in \{1,2,3\}, \; s \in [0,10].
$$

Initial conditions: $x(0)=0$, $y(0)=1$, $\theta(0)=0$.

## Figure 2 – Approximate neutral curves (Application 2)
Curvature approximation (Eq. FD17 upper bound with $\varepsilon=10^{-1}$):

$$
k_p(s) = \left(1 + \frac{s}{10}\right)^{p}, \qquad p \in \{-10,-20,-30\}.
$$

Reference neutral curve: $k(s) = e^{-s}$.
Initial conditions: $x(0)=0$, $y(0)=1$, $\theta(0)=-\pi/4$.

## Figure 3 – Approximate neutral curves parametrised by $N$ (Application 2)
Curvature family:

$$
k_N(s) = \left(1 + \frac{s}{N}\right)^{-10}, \qquad N \in \{2,6,10\}.
$$

Same initial conditions: $x(0)=0$, $y(0)=1$, $\theta(0)=-\pi/4$.

## Figure 4 – ε-neutral divergent curves (Application 3)
Curvature family:

$$
k_p(s) = 1 + p\,s, \qquad p \in \{1,2,3\}.
$$

Neutral reference (Eq. FD17 lower bound): $k(s) = e^{s}$.
Initial conditions: $x(0)=0$, $y(0)=1$, $\theta(0)=-\pi/4$, $s \in [0,2]$.

## Figure 5 – ε-aesthetic curves (Remark 2 & Application 4)
Parameters: $\varepsilon = 1/2$, $a=-1$, $b=1$, $C_1=3$, $k(0)=1$.
Discriminants: $\delta_1 = (\varepsilon + b)^2 + 2aC_1 = -3.75$, $\delta_2 = (\varepsilon - b)^2 + 2aC_1 = -5.75$.
Curvature bounds (Eq. FD34):

$$
\begin{aligned}
 k_{-}(s) &= \exp\!\left(\frac{2}{\sqrt{-\delta_2}} \Big[\arctan\!\Big(\frac{-1}{2\sqrt{-\delta_2}}\Big) - \arctan\!\Big(\frac{-s + 1/2}{\sqrt{-\delta_2}}\Big)\Big]\right), \\
 k_{+}(s) &= \exp\!\left(\frac{2}{\sqrt{-\delta_1}} \Big[\arctan\!\Big(\frac{3}{2\sqrt{-\delta_1}}\Big) - \arctan\!\Big(\frac{-s + 3/2}{\sqrt{-\delta_1}}\Big)\Big]\right),
\end{aligned}
$$

for $s \in [0,1]$.

These two functions `k_{-}(s)` and `k_{+}(s)` are plotted to form Figure 5.
