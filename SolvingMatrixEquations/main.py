import math
import time
import matplotlib.pyplot as plt


def generate_a(n, a_1, a_2, a_3):
    a_matrix = [[0 for _ in range(n)] for _ in range(n)]
    for i in range(n):
        a_matrix[i][i] = a_1
        if i < n - 1:
            a_matrix[i][i + 1] = a_matrix[i + 1][i] = a_2
        if i < n - 2:
            a_matrix[i][i + 2] = a_matrix[i + 2][i] = a_3
    return a_matrix


def matrix_vector_mul(m, v):
    result = [0] * len(v)
    for i in range(len(v)):
        for j in range(len(v)):
            result[i] += m[i][j] * v[j]
    return result


def residual(a, x, b):
    product = matrix_vector_mul(a, x)
    res = [(product[i] - b[i]) for i in range(len(x))]
    return res


def norm(v):
    result = 0
    for num in v:
        result += num ** 2
    return math.sqrt(result)


def gauss_seidel(a, b):
    N = len(a)
    x = [1] * N
    prev_x = [1] * N
    iters = 0
    t_0 = time.time()
    while norm(residual(a, x, b)) > 10 ** (-9):
        for i in range(N):
            sigma = 0
            for j in range(i):
                sigma += a[i][j] * x[j]
            for j in range(i + 1, N):
                sigma += a[i][j] * prev_x[j]
            x[i] = (b[i] - sigma) / a[i][i]
        prev_x = x.copy()
        iters += 1
    t = time.time() - t_0
    return x, iters, t


def jacobi(a, b):
    N = len(a)
    x = [1] * N
    prev_x = [1] * N
    iters = 0
    t_0 = time.time()
    while norm(residual(a, x, b)) > 10 ** (-9):
        for i in range(N):
            sigma = 0
            for j in range(i):
                sigma += a[i][j] * prev_x[j]
            for j in range(i + 1, N):
                sigma += a[i][j] * prev_x[j]
            x[i] = (b[i] - sigma) / a[i][i]
        prev_x = x.copy()
        iters += 1
    t = time.time() - t_0
    return x, iters, t


def lu_factorization(a, b):
    N = len(a)
    x = [0] * N
    y = [0] * N
    t_0 = time.time()
    L = eye(N)
    U = matrix_dup(a)
    # calculate L and U
    for i in range(N - 1):
        for j in range(i + 1, N):
            L[j][i] = U[j][i] / U[i][i]
            for k in range(i, N):
                U[j][k] -= L[j][i] * U[i][k]
    # solution for y
    for i in range(N):
        sigma = 0
        for j in range(i):
            sigma += L[i][j] * y[j]
        y[i] = (b[i] - sigma)
    # solution for x
    for i in reversed(range(N)):
        sigma = 0
        for j in range(i + 1, N):
            sigma += U[i][j] * x[j]
        x[i] = (y[i] - sigma) / U[i][i]

    t = time.time() - t_0
    return x, y, t, norm(residual(a, x, b))


def eye(n):
    result = [[0 for _ in range(n)] for _ in range(n)]
    for i in range(n):
        result[i][i] = 1
    return result


def matrix_dup(m):
    result = [[0 for _ in range(len(m[0]))] for _ in range(len(m))]
    for i in range(len(m)):
        for j in range(len(m[0])):
            result[i][j] = m[i][j]
    return result


def main():
    # A
    a1 = 11
    a2 = a3 = -1
    N = 908
    f = 4
    b = [math.sin(n * (f + 1)) for n in range(N)]
    A = generate_a(N, a1, a2, a3)

    # B
    _, iters, computation_time = gauss_seidel(A, b)
    print("\tGauss-Seidel method\n iterations:", iters, "\n time elapsed:", computation_time)
    _, iters, computation_time = jacobi(A, b)
    print("\tJacobi method\n iterations:", iters, "\n time elapsed:", computation_time)

    # C
    a1 = 3
    A = generate_a(N, a1, a2, a3)
    # _, iters, computation_time = gauss_seidel(A, b)
    # _, iters, computation_time = jacobi(A, b)
    # Iterative methods for this configuration diverge

    # D
    _, _, computation_time, norm_res = lu_factorization(A, b)
    print("\tLU factorization\n time elapsed:", computation_time, "\n residual vector norm:", norm_res)

    # E
    # a1 = 11
    # a2 = a3 = -1
    # f = 4
    # sizes = [100, 500, 1000, 2000, 3000]
    # time_log = [[0 for _ in range(len(sizes))] for _ in range(3)]
    # for i in range(len(sizes)):
    #     print(i)
    #     b = [math.sin(n * (f + 1)) for n in range(sizes[i])]
    #     A = generate_a(sizes[i], a1, a2, a3)
    #     _, _, time_log[0][i] = gauss_seidel(A, b)
    #     _, _, time_log[1][i] = jacobi(A, b)
    #     _, _, time_log[2][i], _ = lu_factorization(A, b)
    #
    # plt.figure()
    # plt.title("Computation time versus matrix size graph for different algorithms")
    # plt.xlabel("Size of matrix")
    # plt.ylabel("Computation time [s]")
    # plt.plot(sizes, time_log[0], label="Gauss-Seidel method")
    # plt.plot(sizes, time_log[1], label="Jacobi method")
    # plt.plot(sizes, time_log[2], label="LU factorization")
    # plt.legend(loc="upper left")
    # plt.show()


main()
