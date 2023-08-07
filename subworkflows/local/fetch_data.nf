// workflow for fetching data

include { FASTQC } from '../../modules/local/fastqc.nf'
include { FETCH_RUN } from '../../modules/local/fetch.nf'
include { FASTERQ_DUMP } from '../../modules/local/fasterq_dump.nf'
include { FASTQ_DL } from '../../modules/local/fastq-dl.nf'

workflow fetch_data {

    take: samples_ch

    main:
        sra_ch          =   FETCH_RUN       ( samples_ch )

        if ( sra_ch.failure ) {
            backup_fastq_ch    =   FASTQ_DL (sra_ch.failure, samples_ch)
        }
        fastq_ch    =   FASTERQ_DUMP    ( sra_ch.sra ).flatten()

    emit:
        fastq_ch
        samples_ch
}
