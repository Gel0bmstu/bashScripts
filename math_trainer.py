#!/usr/bin/python3

import random
import sys
import time

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

def main():
    numbers = generate_numbers()
    state = [0,0,0]

    time_start = int(round(time.time() * 1000))
    while True:
        print_numbers(state, numbers)
        if (state == [1,1,1]):
            break

        answers = input("Enter answers: ").split()
        counter = 0
        for ans in answers:
            while state[counter]:
                counter += 1
            
            if int(ans) == numbers[counter][2]:
                state[counter] = 1 
    time_end = int(round(time.time() * 1000))

    print('Correct!')
    print('Time spanded: {} s.'.format( str((time_end - time_start)/1000) ))

main()
