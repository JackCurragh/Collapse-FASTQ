

process FASTQC {

    tag 'medium'

	publishDir "${params.study_dir}/fastqc", mode: 'copy'

    errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }
	
	input:
	    file fastq 
        path adapter_list

	output:
	    path "*_fastqc.html", emit: fastqc_html
        path "${fastq.baseName}_fastqc/fastqc_data.txt", emit: fastqc_data

    script:
        """
        fastqc --extract -q $fastq --adapters ${adapter_list} 
        # --dir /data2/Jack/temp
        """
}