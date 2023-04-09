
process MULTIQC {

    tag 'medium'
    
	publishDir "${params.output_dir}/multiqc", mode: 'copy'
	
	input:
	    path fastqc_reports
        path fastp_reports

	output:
	    path "multiqc_report.html"

    script:
        """
        multiqc .
        """
}