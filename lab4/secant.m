function [xvect,xdif,fx,it_cnt] = secant(x1, x2, eps, f)
    xvect = [];
    xdif = [];
    fx = [];
    it_cnt = 0;

    while true
        it_cnt = it_cnt + 1;
        x0 = ((x1 * feval(f, x2) - x2 * feval(f, x1)) / (feval(f, x2) - feval(f, x1)));
        c = feval(f, x1) * feval(f, x0);
        x1 = x2;
        x2 = x0;

        xvect(it_cnt) = x0;
        %----logs----
        if it_cnt ~= 1
            xdif(it_cnt) = abs(xvect(it_cnt) - xvect(it_cnt - 1));
        else
            xdif(1) = xvect(it_cnt);
        end
        fx(it_cnt) = feval(f, x0);
        %------------
        if c == 0
            break
        end

        xm = ((x1 * feval(f, x2) - x2 * feval(f, x1)) / (feval(f, x2) - feval(f, x1)));
        if abs(xm - x0) < eps
            break
        end
    end
end