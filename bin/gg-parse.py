#!/usr/bin/env python

'''
gg
parses out the line number from a grep output and creates a vim statement
that will open the file to the exact line number.

@example
    ./Mage/CatalogInventory/Model/Observer.php:130:
                 - will become -
    ./Mage/CatalogInventory/Model/Observer.php +130
'''

import sys
import subprocess

if __name__ == '__main__':
    if len(sys.argv) > 1:
        word = sys.argv[1]
        word = word.replace(':',' +',1)[:-1]
        file_name   = word.split(' ')[0]
        line_number = word.split(' ')[1]

        print word

        # subprocess.Popen(['vim', file_name, line_number], shell=True)

