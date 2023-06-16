#!/usr/bin/env nextflow

/// Specify to use Nextflow DSL version 2
nextflow.enable.dsl=2

/// Import modules and subworkflows
include { collapse } from './subworkflows/local/collapse.nf'

// Log the parameters
log.info """\

=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||                        INSERT PIPELINE NAME                             
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||  Parameters                                                             
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
||  accession_file  : ${params.accession_file}                                     
||  outDir          : ${params.output_dir}                                        
||  workDir         : ${workflow.workDir}
||  profile         : ${workflow.profile}                                     
=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=

"""
// Help Message to prompt users to specify required parameters
def help() {
    log.info"""
  Usage:  nextflow run main.nf --accession_file <path to sample_accession.txt file> --outDir <path to output directory>

  Required Arguments:

  --accession_file    Path to sample_accession.txt file.

  Optional Arguments:

  --outDir	Path to output directory. 
	
""".stripIndent()
}

/// Define the main workflow
workflow {
    /// Define the input channel

    accession_ch = Channel
                    .fromPath( params.accession_file )
                    .splitText() { it.strip() }

    collapse(accession_ch)
}

workflow.onComplete {
    log.info "Pipeline completed at: ${new Date().format('dd-MM-yyyy HH:mm:ss')}"
}
