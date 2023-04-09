
// Example module that runs fastqc on a single fastq file.
// Results are publushed to the study directory in the fastqc directory

process FASTQ_DL {    
	
	input:
	    val accession

	output:
	    path "*.fastq.gz" // ; emit fastq

    script:
        """
        fastq-dl -a $accession --cpus ${task.cpus}
        """
}