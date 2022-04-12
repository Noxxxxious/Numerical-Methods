function [xvect,xdif,fx,it_cnt] = bisect(a, b, eps, f)
    xvect = [];
    xdif = [];
    fx = [];
    it_cnt = 0;

    while (b - a) >= eps
        it_cnt = it_cnt + 1;
        x = (a + b) / 2;
        y = feval(f, x);
        %----logs----
        xvect(it_cnt) = x;
        if it_cnt ~= 1
            xdif(it_cnt) = abs(xvect(it_cnt) - xvect(it_cnt - 1));
        else
            xdif(1) = xvect(it_cnt);
        end
        fx(it_cnt) = y;
        %------------
        if y == 0
            break
        end

        if feval(f, a) * y < 0
            b = x;
        else
            a = x;
        end
    end
end