[XX, YY] = meshgrid(linspace(0, 100, 101),linspace(0, 100, 101));
K = [5, 15, 25, 35];

for i = K
    [x, y, f, xp, yp] = lazik(i);

    subplot(2, 2, 1);
    plot(xp, yp, '-o', 'linewidth', 1.25, 'markersize', 4);
    title("Rover route, K = " + i);
    xlabel("x [m]");
    ylabel("y [m]");

    subplot(2, 2, 2);
    plot3(x, y, f, 'o');
    title("Sample values, K = " + i);
    xlabel("x [m]");
    ylabel("y [m]");
    zlabel("Ionizing radiation value");

    p = polyfit2d(x, y, f);
    FF = polyval2d(XX, YY, p);
    subplot(2, 2, 3);
    surf(XX, YY, FF);
    shading flat;
    title("Polynomial interpolation, K = " + i);
    xlabel("x [m]");
    ylabel("y [m]");
    zlabel("Ionizing radiation value");

    p = trygfit2d(x,y,f);
    FF = trygval2d(XX,YY,p);
    subplot(2, 2, 4);
    surf(XX, YY, FF);
    shading flat;
    title("Trigonometric interpolation, K = " + i);
    xlabel("x [m]");
    ylabel("y [m]");
    zlabel("Ionizing radiation value");
    
    file_name = sprintf("K=%d.png", i);
    saveas(gcf, file_name);
end