function reproduce_figures()
%REPRODUCE_FIGURES Numerical reproduction of Figures 1-5 from
% "On Approximate Aesthetic Curves" (Symmetry, 2020).
%
% The script generates planar curves using the curvature prescriptions and
% initial data provided in the paper, then saves plots that mirror the five
% figures discussed in the article. Numerical integration uses the
% cumulative trapezoidal rule via MATLAB's CUMTRAPZ.
%
% Usage: run this script in MATLAB; output PNGs will be written to the
% "output" subdirectory next to this file.

    outDir = fullfile(fileparts(mfilename('fullpath')), 'output');
    if ~exist(outDir, 'dir')
        mkdir(outDir);
    end

    % Figure 1: epsilon-neutral convergent curves (logarithmic spirals)
    fig = figure('Visible', 'off'); hold on; grid on;
    pVals = [1, 2, 3];
    s = linspace(0, 10, 2000);
    for p = pVals
        kfun = @(sigma) 1 ./ (1 + p .* sigma);
        [x, y] = curve_from_curvature(kfun, s, 0, 1, 0);
        plot(x, y, 'DisplayName', sprintf('p = %d', p), 'LineWidth', 1.5);
    end
    axis equal tight;
    xlabel('x'); ylabel('y');
    title('\epsilon-neutral convergent curves (Fig. 1)');
    legend('Location', 'best');
    exportgraphics(fig, fullfile(outDir, 'figure1.png'), 'Resolution', 300);
    close(fig);

    % Figure 2: approximate neutral curves vs. neutral reference k = e^{-s}
    fig = figure('Visible', 'off'); hold on; grid on;
    pVals = [-10, -20, -30];
    s = linspace(0, 10, 2500);
    for p = pVals
        kfun = @(sigma) (1 + sigma / 10) .^ p;
        [x, y] = curve_from_curvature(kfun, s, 0, 1, -pi/4);
        plot(x, y, 'DisplayName', sprintf('p = %d', p), 'LineWidth', 1.5);
    end
    [xRef, yRef] = curve_from_curvature(@(sigma) exp(-sigma), s, 0, 1, -pi/4);
    plot(xRef, yRef, '--', 'DisplayName', 'k(s) = e^{-s}', 'LineWidth', 1.5);
    axis equal tight;
    xlabel('x'); ylabel('y');
    title('Approximate neutral curves (Fig. 2)');
    legend('Location', 'best');
    exportgraphics(fig, fullfile(outDir, 'figure2.png'), 'Resolution', 300);
    close(fig);

    % Figure 3: approximate neutral curves parametrised by N
    fig = figure('Visible', 'off'); hold on; grid on;
    nVals = [2, 6, 10];
    s = linspace(0, 10, 2500);
    for N = nVals
        kfun = @(sigma) (1 + sigma / N) .^ (-10);
        [x, y] = curve_from_curvature(kfun, s, 0, 1, -pi/4);
        plot(x, y, 'DisplayName', sprintf('N = %d', N), 'LineWidth', 1.5);
    end
    axis equal tight;
    xlabel('x'); ylabel('y');
    title('Approximate neutral curves (Fig. 3)');
    legend('Location', 'best');
    exportgraphics(fig, fullfile(outDir, 'figure3.png'), 'Resolution', 300);
    close(fig);

    % Figure 4: epsilon-neutral divergent curves (Euler spirals) and neutral reference
    fig = figure('Visible', 'off'); hold on; grid on;
    pVals = [1, 2, 3];
    s = linspace(0, 2, 4000);
    for p = pVals
        kfun = @(sigma) 1 + p .* sigma;
        [x, y] = curve_from_curvature(kfun, s, 0, 1, -pi/4);
        plot(x, y, 'DisplayName', sprintf('p = %d', p), 'LineWidth', 1.5);
    end
    [xRef, yRef] = curve_from_curvature(@(sigma) exp(sigma), s, 0, 1, -pi/4);
    plot(xRef, yRef, '--', 'DisplayName', 'k(s) = e^{s}', 'LineWidth', 1.5);
    axis equal tight;
    xlabel('x'); ylabel('y');
    title('\epsilon-neutral divergent curves (Fig. 4)');
    legend('Location', 'best');
    exportgraphics(fig, fullfile(outDir, 'figure4.png'), 'Resolution', 300);
    close(fig);

    % Figure 5: two epsilon-aesthetic curves (presented via their curvature graphs)
    fig = figure('Visible', 'off'); hold on; grid on;
    epsVal = 0.5;
    a = -1; b = 1; C1 = 3;
    delta1 = (epsVal + b)^2 + 2 * a * C1;
    delta2 = (epsVal - b)^2 + 2 * a * C1;
    if delta1 >= 0 || delta2 >= 0
        error('Expected negative discriminants for the chosen parameters.');
    end
    s = linspace(0, 1, 800);
    root1 = sqrt(-delta1);
    root2 = sqrt(-delta2);
    kMinus = exp((2 / root2) * (atan(-1 / (2 * root2)) - atan((-s + 0.5) ./ root2)));
    kPlus  = exp((2 / root1) * (atan(3 / (2 * root1)) - atan((-s + 1.5) ./ root1)));
    plot(s, kMinus, 'LineWidth', 1.5, 'DisplayName', '\it{k}_{-}(s)');
    plot(s, kPlus,  'LineWidth', 1.5, 'DisplayName', '\it{k}_{+}(s)');
    xlabel('s'); ylabel('k(s)');
    title('\epsilon-aesthetic curves (Fig. 5)');
    legend('Location', 'best');
    exportgraphics(fig, fullfile(outDir, 'figure5.png'), 'Resolution', 300);
    close(fig);
end

function [x, y, theta] = curve_from_curvature(kfun, s, x0, y0, theta0)
%C curve_from_curvature Numerically integrate a planar curve from its curvature.
%   [X,Y,THETA] = curve_from_curvature(KFUN, S, X0, Y0, THETA0) integrates the
%   curvature function KFUN sampled over the vector S, returning planar
%   coordinates (X,Y) and tangent angle THETA. Integration uses the
%   cumulative trapezoidal rule with the provided initial pose (X0,Y0,THETA0).

    k = kfun(s);
    theta = theta0 + cumtrapz(s, k);
    x = x0 + cumtrapz(s, cos(theta));
    y = y0 + cumtrapz(s, sin(theta));
end
