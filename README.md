
# Collapse FASTQ Files
## Introduction 

### Inputs
This pipeline is general purpose for preparing FASTQ read files but was specifically developed to prepare data for [RiboSeq.Org](https://riboseq.org/). 
Inputs for this pipeline may vary. Options include:
- Study accession
- Sample accession list 
- Path to FASTQ directory

### Outputs
#### Collapsed Read File
The primary output is a gzipped collapsed read file of the following format:
```
>read<read_number>_x<read_count>
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
```
where:
- `<read_number>` signifies that this is the nth read processed. 
- `<read_count>` signifies how many times reads with this exact sequence was seen

#### FastQC Report 
The `html` report for each sample is outputted 

#### FastP
The `html` report from FastP 

#### MultiQC Report
Combined report for each pipeline run. Merged FastP and FastQC 

## Requirements 
This pipeline can be run using each of the following container methods
| Method      | Instructions                                                                                   |
| ----------- | ---------------------------------------------------------------------------------------------- |
| Singularity | [docs.syslabs.io](https://docs.sylabs.io/guides/3.0/user-guide/installation.html)              |
| Docker      | [docs.docker.com](https://docs.docker.com/engine/install/)                                     |
| Conda       | [docs.conda.io](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)  |


## Setup
##### Singularity
```
sudo singularity build singularity/pipeline Singularity
```
Then as the profile `singularity` specifies `container = 'singularity/pipeline'` use the following to execute:
```
nextflow run main.nf -profile singularity
```

##### Docker
```
docker build . -t pipeline-image
```
Then as the profile `docker` specifies `container = 'pipeline-image:latest'` use the following to execute:
```
nextflow run main.nf -profile docker
```

##### Conda 
Create a conda definition yaml file [eg. here](conda/example.yml)
```
nextflow run main.nf -profile conda
```

## Usage
Call the pipeline directly
```
nextflow run main.nf
```

Run with all the frills
```
bash scripts/run-w-frills <params-file> <profile name from nextflow.config>
```
Example
```
bash scripts/run-w-frills example_parameters.yml standard
```

