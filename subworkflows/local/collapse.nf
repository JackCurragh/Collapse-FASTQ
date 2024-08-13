

// Include the necessary modules for this workflow
include { FASTQC } from '../../modules/local/fastqc.nf'
include { FASTQ_DL } from '../../modules/local/fastq-dl.nf'
include { MULTIQC } from '../../modules/local/multiqc.nf'
include { FASTP } from '../../modules/local/fastp.nf'
include { COLLAPSE_FASTQ } from '../../modules/local/collapse.nf'


workflow collapse {
    take:
        sample_accession

    main:
        FASTQ_DL(sample_accession)
        FASTQC(FASTQ_DL.out, "$projectDir/scripts/adapter_list.tsv")
        FASTP(FASTQ_DL.out)
        MULTIQC(FASTQC.out.fastqc_results.collect().ifEmpty([]), FASTP.out.fastp_json.collect().ifEmpty([]))
        COLLAPSE_FASTQ(FASTP.out.fastp_fastq)
    
    emit:
        FASTP.out.fastp_fastq
}