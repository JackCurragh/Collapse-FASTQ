

process COLLAPSE_FASTQ {
	publishDir "${params.study_dir}/collapsed_fastq/${BioProject}", mode: 'copy'

    // errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }

    input:
        path fastq
        tuple val(BioProject), val(Run)

    output:
        path "*.fastq.gz"

    script:
    """
    python3 $projectDir/scripts/collapse_fastq.py -i $fastq -o ${fastq.baseName}_collapsed.fastq.gz
    """
}