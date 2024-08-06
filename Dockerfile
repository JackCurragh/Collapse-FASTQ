FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    default-jre \
    perl \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Download and install FastQC
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && \
    unzip fastqc_v0.11.9.zip && \
    chmod +x FastQC/fastqc && \
    ln -s /FastQC/fastqc /usr/local/bin/fastqc

# Download and install fastp
RUN wget http://opengene.org/fastp/fastp && \
    chmod a+x ./fastp && \
    mv ./fastp /usr/local/bin/fastp

# Download and install sratoolkit
RUN wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz && \
    tar -xzf sratoolkit.tar.gz && \
    mv sratoolkit.*-ubuntu64 /usr/local/sratoolkit && \
    ln -s /usr/local/sratoolkit/bin/fasterq-dump /usr/local/bin/fasterq-dump

# Create and activate a virtual environment, and install Python packages
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --upgrade pip && \
    pip install multiqc fastq-dl biopython awscli

# Set the default command
CMD ["latest"]