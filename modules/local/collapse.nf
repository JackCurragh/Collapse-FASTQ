

process COLLAPSE_FASTQ {
    publishDir "${params.output_dir}/fastq", mode: 'copy', pattern: '*.fastq.gz'

    input:
        path fastq

    output:
        path "*.fastq.gz"

    script:
    """
    python3 $projectDir/scripts/collapse_fastq.py -i $fastq -o ${fastq.baseName}_collapsed.fastq.gz
    """
}