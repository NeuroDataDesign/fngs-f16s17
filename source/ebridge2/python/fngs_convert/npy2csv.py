#!/usr/bin/python2.7
# a script for converting from npz to csv format.
# written by eric bridgeford
# usage:
#    ./npz2csv.py npzpath csvpath
#
import numpy as np
from argparse import ArgumentParser

def npy2csv(npyname, csvname):
    data = np.load(npyname)['roi']
    np.savetxt(csvname, data)

def main():
    parser=ArgumentParser(description="")
    parser.add_argument("in_file", help="the npy file to convert to csv.")
    parser.add_argument("out_file", help="the csv file to be converted to.")
    result=parser.parse_args()
    npy2csv(result.in_file, result.out_file)

if __name__ == "__main__":
    main()

