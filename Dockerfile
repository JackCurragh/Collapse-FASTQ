FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    default-jre \
    perl \
    python-setuptools \
    python3 \
    python3-pip

# Download and install FastQC
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && \
    unzip fastqc_v0.11.9.zip && \
    chmod +x FastQC/fastqc && \
    ln -s /FastQC/fastqc /usr/local/bin/fastqc

RUN wget http://opengene.org/fastp/fastp && \
    chmod a+x ./fastp

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install multiqc fastq-dl biopython


# Set the default command
CMD ["latest"]