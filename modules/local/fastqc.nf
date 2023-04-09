
// Example module that runs fastqc on a single fastq file.
// Results are publushed to the study directory in the fastqc directory

process FASTQC {

    tag 'medium'
    
	publishDir "${params.output_dir}/fastqc", mode: 'copy'
	
	input:
	    file fastq 

	output:
	    path "*_fastqc.{zip,html}", emit: fastqc_results

    script:
        """
        fastqc -q $fastq --adapters ${params.adapters_tsv} --threads ${task.cpus}
        """
}