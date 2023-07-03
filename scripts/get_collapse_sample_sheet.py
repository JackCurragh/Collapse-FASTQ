'''
Produces a sample sheet for the collapse pipeline

Exclude samples that have already been collapsed and are in data/RiboSeqOrg/collapsed_fastq

Usage: python get_collapse_sample_sheet.py -i <data/RiboSeqOrg/fastq> -o <data/RiboSeqOrg/collapse_sample_sheet.tsv>
'''

import argparse
import os 
import pandas as pd


def get_processed_samples(processed_dir: str) -> list:
    '''
    Get a list of samples that have already been processed

    Input:
        processed_dir: str

    Output:
        list of samples that have already been processed
    '''
    processed_samples = []
    for dir in os.listdir(processed_dir):
        if os.path.isdir(os.path.join(processed_dir, dir)) == False:
            continue
        for file in os.listdir(os.path.join(processed_dir, dir)):
            if file.endswith('.fastq.gz'):
                processed_samples.append(file.split('_')[0])

    return processed_samples


def get_collapse_sample_sheet(metadata: str, outfile: str, processed: str,  num_samples: int) -> None:
    '''
    Produce a sample sheet for the collapse pipeline

    Input:
        metadata file path : str
        outfile: str
        num_samples: int
    '''
    processed_samples = get_processed_samples(processed)

    metadata = pd.read_csv(metadata)
    metadata = metadata[metadata['Run'].isin(processed_samples) == False]

    metadata = metadata.head(num_samples)
    sample_sheet = metadata[['BioProject', 'Run']]
    sample_sheet.columns = ['BioProject', 'Run']
    sample_sheet.to_csv(outfile, sep='\t', index=False)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', help='path to metadata file')
    parser.add_argument('-o', help='path to output sample sheet', default='sample_sheet.tsv')
    parser.add_argument('-p', help='path to processed FASTQ directory', default='/data1/Jack/projects/Collapse-FASTQ/data/RiboSeqOrg/collapsed_fastq')
    parser.add_argument('-n', help='number of samples to process', default=100, type=int)

    args = parser.parse_args()
    get_collapse_sample_sheet(args.i, args.o, args.p, args.n)