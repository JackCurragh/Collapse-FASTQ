
// Example module that runs fastqc on a single fastq file.
// Results are publushed to the study directory in the fastqc directory

process FASTQ_DL {    
	
	input:
        val failure
        tuple val(study_accession), val(run)

	output:
	    path "*.fastq.gz", emit: fastq

    script:
        """
        fastq-dl -a $run --cpus ${task.cpus}
        """
}