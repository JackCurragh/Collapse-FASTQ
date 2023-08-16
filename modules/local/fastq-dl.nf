
// Example module that runs fastqc on a single fastq file.
// Results are publushed to the study directory in the fastqc directory

process FASTQ_DL {    
        errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }

	input:
        val failure
        tuple val(study_accession), val(run)

	output:
	    path "*.fastq.gz", emit: fastq

    script:
        """
        echo "${study_accession}        ${run}" >> /data1/Jack/projects/Collapse-FASTQ/data/RiboSeqOrg/data/RiboSeqOrg/failed.txt
        fastq-dl -a $run --cpus 20 --outdir /data2/Jack/temp --silent
        """
}