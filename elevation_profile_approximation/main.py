import matplotlib.pyplot as plt
import csv


def load_data(data_path):
    with open(data_path, newline='') as f:
        reader = csv.reader(f)
        data = list(reader)
        data.pop(0)
        data = [[float(x), float(y)] for (x, y) in data]
        return data


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


def LU_factorization(a, b):
    N = len(a)
    L = eye(N)
    U = [[0 for _ in range(N)] for _ in range(N)]
    P = matrix_dup(a)
    x = [1] * N
    y = [0] * N

    for i in range(N):
        for j in range(i + 1):
            U[j][i] += P[j][i]
            for k in range(j):
                U[j][i] -= L[j][k] * U[k][i]
        for j in range(i + 1, N):
            for k in range(i):
                L[j][i] -= L[j][k] * U[k][i]
            L[j][i] = (L[j][i] + P[j][i]) / U[i][i]
    for i in range(N):
        sigma = b[i]
        for j in range(i):
            sigma -= L[i][j] * y[j]
        y[i] = sigma / L[i][i]
    for i in reversed(range(N)):
        sigma = y[i]
        for j in range(i + 1, N):
            sigma -= U[i][j] * x[j]
        x[i] = sigma / U[i][i]
    return x


def splines(points, x_points):
    n = len(points)
    A = [[0 for _ in range(4 * (n - 1))] for _ in range(4 * (n - 1))]
    b = [0] * (4 * (n - 1))
    for i in range(n - 1):
        x, y = points[i]
        row = [0] * (4 * (n - 1))
        row[4 * i + 3] = 1
        A[4 * i + 3] = row
        b[4 * i + 3] = y
    for i in range(n - 1):
        x1, y1 = points[i + 1]
        x0, y0 = points[i]
        h = x1 - x0
        row = [0] * (4 * (n - 1))
        row[4 * i] = h ** 3
        row[4 * i + 1] = h ** 2
        row[4 * i + 2] = h ** 1
        row[4 * i + 3] = 1
        A[4 * i + 2] = row
        b[4 * i + 2] = y1
    for i in range(n - 2):
        x1, y1 = points[i + 1]
        x0, y0 = points[i]
        h = x1 - x0
        row = [0] * (4 * (n - 1))
        row[4 * i] = 3 * (h ** 2)
        row[4 * i + 1] = 2 * h
        row[4 * i + 2] = 1
        row[4 * (i + 1) + 2] = -1
        A[4 * i] = row
        b[4 * i] = 0
    for i in range(n - 2):
        x1, y1 = points[i + 1]
        x0, y0 = points[i]
        h = x1 - x0
        row = [0] * (4 * (n - 1))
        row[4 * i] = 6 * h
        row[4 * i + 1] = 2
        row[4 * (i + 1) + 1] = -2
        A[4 * (i + 1) + 1] = row
        b[4 * (i + 1) + 1] = 0

    row = [0] * (4 * (n - 1))
    row[1] = 2
    A[1] = row
    b[1] = 0
    row = [0] * (4 * (n - 1))
    x1, y1 = points[-1]
    x0, y0 = points[-2]
    h = x1 - x0
    row[1] = 2
    row[-4] = 6 * h
    A[-4] = row
    b[-4] = 0

    params = LU_factorization(A, b)
    p = []
    for i in range(0, len(params), 4):
        p.append(params[i:i + 4])

    results = []
    for x in x_points:
        for i in range(1, len(points)):
            x0 = points[i - 1][0]
            x1 = points[i][0]
            if x0 <= x <= x1:
                p1, p2, p3, p4 = p[i - 1]
                results.append(p1 * ((x - x0) ** 3) + p2 * ((x - x0) ** 2) + p3 * (x - x0) + p4)
                break
    return results


def lagrange(points, x_points):
    results = list()
    for x in x_points:
        y_p = 0
        for i, (x_i, y_i) in enumerate(points):
            p = 1
            for j, (x_j, y_j) in enumerate(points):
                if i != j:
                    p *= (x - x_j) / (x_i - x_j)
            y_p += p * y_i
        results.append(y_p)
    return results


def plot_results(x_cords, y_cords, result, samples, n, path, title):
    plt.plot(x_cords, y_cords, color="green", label="original data")
    plt.plot(x_cords[:len(result)], result, color="magenta", label="interpolated data")
    samples_x, samples_y = zip(*samples)
    plt.plot(samples_x, samples_y, "o", label="sample points")
    plt.title(title.capitalize() + ": " + path.replace("data/", "").replace(".csv", "") + ", N = " + str(n))
    plt.legend()
    plt.savefig(path.replace(".csv", "") + "_" + title + "_" + str(n) + ".png")
    plt.close()


def make_intervals(points, count):
    intervals = []
    a = 0
    b = len(points) - 1
    dx = (b - a) / (count - 1)
    while a <= b:
        intervals.append(points[int(a)])
        a += dx
    return intervals


def main():
    data_paths = ["data/MountEverest.csv", "data/GlebiaChallengera.csv", "data/WielkiKanionKolorado.csv"]
    SAMPLE_COUNT = 15
    for path in data_paths:
        data_points = load_data(path)
        x_cords, y_cords = zip(*data_points)
        samples = make_intervals(data_points, SAMPLE_COUNT)

        lagrange_result = lagrange(samples, x_cords)
        splines_result = splines(samples, x_cords)

        plot_results(x_cords, y_cords, lagrange_result, samples, SAMPLE_COUNT, path, "lagrange")
        plot_results(x_cords, y_cords, splines_result, samples, SAMPLE_COUNT, path, "splines")


main()
