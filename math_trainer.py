#!/usr/bin/python3

import random
import sys
import time
import os
import re
import sys

from datetime import datetime
from matplotlib import pyplot as plt

def generate_numbers():
    numbers = {}
    for i in range(3):
        numbers[i] = []
        while True:
            a = random.randrange(1, 1000)
            b = random.randrange(1, 1000)
            if a + b < 1000:
                numbers[i] += [a, b, a+b]
                break
    
    return numbers

def print_numbers(state, numbers):
    for i in range(3):
        if state[i]:
            print("[+] {} + {} = {}".format(numbers[i][0], numbers[i][1], numbers[i][2]), flush=True)
        else:
            print("[*] {} + {} =".format(numbers[i][0], numbers[i][1]), flush=True)

def log_stats(time, mistakes):
    with open('{}/math_stats.txt'.format(os.environ.get('BASHSCRIPTS_DIR')), 'a') as f:
        d = datetime.now().strftime("%d-%m-%Y_%H:%M:%S")
        f.write('{} {} {}\n'.format(d, time, mistakes))

def print_statistics():
    with open('{}/math_stats.txt'.format(os.environ.get('BASHSCRIPTS_DIR')), 'r') as f:
        dates = []
        time = []
        mistakes = []
        for line in f:
            stats = line.split()
            dates.append(datetime.strptime(stats[0], "%d-%m-%Y_%H:%M:%S"))
            time.append(float(stats[1]))
            mistakes.append(int(stats[2]))
    
    print('Average time:     {}'.format(sum(time) / len(time)))
    print('Average mistakes: {}'.format(sum(mistakes) / len(mistakes)))

    plt.plot(time)
    plt.grid()
    plt.suptitle('Average time', fontsize=20)
    plt.xlabel('Takes count', fontsize = 30)
    plt.ylabel('Time spended', fontsize = 30)
    plt.gcf().autofmt_xdate()
    plt.show()


def main():
    if len(sys.argv[1:]) > 1:
        print('There is only 1 agr allowed: -s/--stats')
        exit(0)
    elif len(sys.argv[1:]) == 1:
        if sys.argv[1] == '-s' or sys.argv[1] == '--stats':
            print_statistics()
        else:
            print('There is only 1 agr allowed: -s/--stats')
        exit(0)

    numbers = generate_numbers()
    state = [0,0,0]
    mistakes = -1

    time_start = int(round(time.time() * 1000))
    while True:
        print_numbers(state, numbers)
        if (state == [1,1,1]):
            break
        else:
            mistakes += 1

        answers = input("Enter answers: ").split()
        answers = [int(re.sub(r'[^\d]', '', a)) for a in answers]
        
        counter = 0
        for ans in answers:
            while state[counter]:
                counter += 1
            
            if int(ans) == numbers[counter][2]:
                state[counter] = 1

            counter += 1
    time_end = int(round(time.time() * 1000))
    time_diff = str((time_end - time_start)/1000)


    log_stats(time_diff, mistakes)

    print('Correct!')
    print('Time spanded: {} s.'.format(time_diff))
    print('Mistakes cout: {}.'.format(mistakes))

main()
