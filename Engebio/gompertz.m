clear
clc

t = [0.00
     0.83
     1.66
     2.48
     3.31
     4.14
     4.97
     5.79
     6.62
     7.45
     8.28
     9.10
     9.93
    10.76
    11.59
    12.41
    13.24
    14.07
    14.90
    15.72
    16.55
    17.38
    18.21
    19.03
    19.86
    20.69
    21.52
    22.34];

X = [0.0150
     0.0177
     0.0208
     0.0245
     0.0289
     0.0340
     0.0400
     0.0471
     0.0555
     0.0653
     0.0769
     0.0905
     0.1064
     0.1251
     0.1470
     0.1726
     0.2026
     0.2375
     0.2782
     0.3252
     0.3793
     0.4409
     0.5100
     0.5851
     0.6604
     0.7237
     0.7562
     0.7638];

[xData, yData] = prepareCurveData( t, X );

% Set up fittype and options.
ft = fittype( 'X0*exp(A*exp(-exp(-um*exp(1)/A*(t-lambda)+1)))', 'independent', 't', 'dependent', 'X' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 0 0];
opts.StartPoint = [0.964888535199277 0.157613081677548 0.970592781760616 0.957166948242946];
opts.Upper = [Inf 0.015 Inf Inf];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts )

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'X vs. t', 'untitled fit 1', 'Location', 'best' );
% Label axes
xlabel( 't' );
ylabel( 'X' );