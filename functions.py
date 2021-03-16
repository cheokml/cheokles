from datetime import datetime
import json
from json import JSONDecodeError
import urllib3
import pandas as pd
from config import Config
from sqlalchemy import create_engine
import psycopg2
import boto3
import os
import glob
import win32com.client as win32


def current_time(message):
    """ Prints current time + message

    Parameters
    ___________
    :param  message:  A string that should be returned with the time

    Returns
    ___________
    :return: time + message
    """
    return print(f"{datetime.now().strftime('%H:%M:%S')} - {message}")


def directory_check(dir):
    """ Directory check, if no such directory, create it

    Parameters
    ___________
    :param   dir: string: Checks if the string is a directory in repo

    No Returns
    """
    if not os.path.exists(dir):
        os.mkdir(dir)
    return


def combine_csv(dir, extension='', file_name=''):
    """ Combines all files in the specified directory (Default is csv)

    Parameters
    ___________
    :param       dir:   The directory where you want the files to be combined
    :param extension:   The extension of the files you want to combine
    :param file_name:   The file name that you want the file saved as

    Returns
    ___________
    :return combined_csv:
    """

    owd = os.getcwd()
    os.chdir(dir)
    if extension == '':
        extension = 'csv'

    current_time(f'Begin combining {extension} files')
    all_filenames = [i for i in glob.glob('*.{}'.format(extension))]
    combined_csv = pd.concat([pd.read_csv(f) for f in all_filenames])
    current_time(f'Files combined, Now exporting to csv')

    if file_name == '':
        combined_csv.to_csv("combined_csv.csv", index=False, encoding='utf-8-sig')
    else:
        combined_csv.to_csv(f"{file_name}.csv", index=False, encoding='utf-8-sig')

    current_time(f'Export complete')
    os.chdir(owd)
    return combined_csv


def float_to_int(df, col):
    """ Converts a column from a dataframe to an integer

    Parameters
    ___________
    :param  df:   The dataframe that the column is from
    :param col:   The column that is a float type that you want to convert to integer

    Returns
    ___________
    :return  df[col]:  Returns a dataframe column
    """

    df[col] = pd.array(round(df[col].astype(float)), dtype='Int64')
    return df[col]


def load_json(file, dir=None):
    """ Loads json file into variable query

    Parameters
    ___________
    :param file:  string:  name of the json file without .json
    :param  dir:  string:  the directory the file is in

    Returns
    ___________
    :return:  query: the json file loaded
    """
    if dir is None:
        with open(f"{file}.json", "r") as r:
            data = json.load(r)
    else:
        with open(f"{dir}/{file}.json", "r") as r:
            data = json.load(r)
    return data