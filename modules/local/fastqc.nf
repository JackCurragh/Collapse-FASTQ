

process FASTQC {

    tag 'medium'

	publishDir "${params.study_dir}/fastqc", mode: 'copy'

    errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }
	
	input:
	    file fastq 

	output:
	    path "*_fastqc.html", emit: fastqc_html
        path "${fastq}c/fastqc_data.txt", emit: fastqc_data

    script:
        """
        fastqc --extract -q $fastq --adapters $projectDir/scripts/adapter_list.tsv
        """
}