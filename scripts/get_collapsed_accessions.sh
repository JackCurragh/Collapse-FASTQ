# Path: scripts/get_collapsed_accessions.sh

# Get all accessions from collapsed fastq files

ls -l /data1/Jack/projects/Collapse-FASTQ/data/RiboSeqOrg/collapsed_fastq/*/*.fastq.gz | cat > data/collapsed.txt

cut -f10 -d"/" data/collapsed.txt | cat > data/collapsed_filenames.txt 

cut -f1 -d"_" data/collapsed_filenames.txt
