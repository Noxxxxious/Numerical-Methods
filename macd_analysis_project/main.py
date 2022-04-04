import pandas
import matplotlib.pyplot as plt
import math


def ema(n, data, current):
    alpha = 2 / (n + 1)
    nominator = 0
    denominator = 0

    exp = 0
    for i in reversed(range(max(0, current - n + 1), current + 1)):
        nominator += data[i] * ((1 - alpha) ** exp)
        denominator += (1 - alpha) ** exp
        exp += 1

    return nominator / denominator


def macd(data):
    macd_values = list()
    for day in range(len(data)):
        macd_values.append(ema(12, data, day) - ema(26, data, day))
    return macd_values


def signal(macd_values):
    signal_values = list()
    for day in range(len(macd_values)):
        signal_values.append(ema(9, macd_values, day))
    return signal_values


wig20_data = pandas.read_csv("wig20_d.csv")
wig20_data_closing = wig20_data['Zamkniecie'].tolist()
plt.plot(wig20_data_closing)
plt.title("WIG20 index value")
plt.xlabel("Day")
plt.ylabel("Value")
plt.show()

MACD = macd(wig20_data_closing)
SIGNAL = signal(MACD)

plt.plot(MACD, label="MACD")
plt.plot(SIGNAL, label="SIGNAL")
plt.title("MACD and SIGNAL indicator graph")
plt.xlabel("Day")
plt.ylabel("Value")
plt.legend(loc="lower left")
plt.show()

print("-----First day-----")
actions = 1000
wallet = 0
print("Actions:", actions, "  Wallet: ", wallet)
network_val = actions * wig20_data_closing[0] + wallet
print("Network value:", network_val)
for i in range(1, len(MACD)):
    if MACD[i] > SIGNAL[i] and MACD[i - 1] < SIGNAL[i - 1]:
        buy = math.floor(wallet / math.floor(wig20_data_closing[i]))
        wallet -= buy * wig20_data_closing[i]
        actions += buy
    if MACD[i] < SIGNAL[i] and MACD[i - 1] > SIGNAL[i - 1]:
        wallet += actions * wig20_data_closing[i]
        actions = 0

network_val_fin = actions * wig20_data_closing[len(wig20_data_closing) - 1] + wallet
print("-----Final day-----")
print("Actions:", actions, " Wallet: %.2f" % wallet)
print("Network value: %.2f" % network_val_fin)
print("-------------------")
print("Overall profit: %.2f" % (100 * (network_val_fin - network_val) / network_val), "%", sep="")
