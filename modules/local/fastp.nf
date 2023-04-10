process FASTP {

    tag 'high'
    
    publishDir "${params.output_dir}/fastp", mode: 'copy', pattern: "*.fastp.html"
	input:
	    file fastq 

	output:
	    path "*fastp.html", emit: fastp_report
        path "*.fastp.json", emit: fastp_json
        path "*.fastp.fastq.gz", emit: fastp_fastq


    script:
        """
        fastp -i $fastq -o ${fastq}.fastp.fastq.gz -h ${fastq}.fastp.html --adapter_fasta ${params.adapters_fa} --thread ${task.cpus} --json ${fastq}.fastp.json
        """
}