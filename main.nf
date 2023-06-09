#!/usr/bin/env nextflow

/// Specify to use Nextflow DSL version 2
nextflow.enable.dsl=2

/// Import modules and subworkflows
include { fetch_data } from './subworkflows/local/fetch_data.nf'
include { preprocessing } from './subworkflows/local/preprocessing.nf'

// Log the parameters
log.info """\

=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||                 RiboSeqOrg Data Processing Pipeline                            
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||  Parameters                                                             
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||  Sample Sheet    : ${params.sample_sheet}                                     
||  workDir         : ${workflow.workDir}   
||  study_dir       : ${params.study_dir}                                     
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=

"""
// Help Message to prompt users to specify required parameters
def help() {
    log.info"""
  Usage:  nextflow run main.nf --input <path_to_fastq_dir> 

  Required Arguments:

  --input    Path to directory containing fastq files.

  Optional Arguments:

  --outDir	Path to output directory. 
	
""".stripIndent()
}

workflow {
    samples_ch  =   Channel
                        .fromPath(params.sample_sheet)
                        .splitCsv(header: true, sep: '\t')
                        .map { row -> tuple("${row.BioProject}", "${row.Run}")}

    fetch_data_ch           =   fetch_data(samples_ch)

    collapsed_fastq_ch      =   preprocessing(fetch_data_ch.fastq_ch, samples_ch)
}

workflow.onComplete {
    log.info "Pipeline completed at: ${new Date().format('dd-MM-yyyy HH:mm:ss')}"
}
