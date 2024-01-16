import sys

import pandas as pd 

print(sys.argv)  #command line arguments passed to the script

day = sys.argv[1]

# some fancy stuff with pandas for first trial with docker

print(f'job finished successfully for day = {day}')