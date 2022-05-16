[XX, YY] = meshgrid(linspace(0, 100, 101),linspace(0, 100, 101));
K = [5:45];
poly_d = [];
trig_d = [];

for i = K
    [x, y, f] = lazik(i);
    p_poly = polyfit2d(x, y, f);
    FF_poly = polyval2d(XX, YY, p_poly);
    p_trig = trygfit2d(x, y, f);
    FF_trig = trygval2d(XX, YY, p_trig);

    if i ~= 5
        poly_d = [poly_d max(max(abs(FF_poly - FF_prev_poly)))];
        trig_d = [trig_d max(max(abs(FF_trig - FF_prev_trig)))];
    end
    FF_prev_poly = FF_poly;
    FF_prev_trig = FF_trig;
end


x_label = "Number of measuring locations - K";
y_label = "Maximum difference of interpolated functions";

plot(K(2:end), poly_d);
title("Convergence for polynomial interpolation");
xlabel(x_label);
ylabel(y_label);
print -dpng polynomial_convergence.png

plot(K(2:end), trig_d);
title("Convergence for trigonometric interpolation");
xlabel(x_label);
ylabel(y_label);
print -dpng trigonometric_convergence.png


