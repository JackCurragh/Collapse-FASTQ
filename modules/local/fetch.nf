process FETCH_RUN {
    tag 'high'

 //  errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }

    input:
        tuple val(study_accession), val(run)

    output:
        path("${run}"), emit: sra, optional: true
        env failure, emit: failure, optional: true

    script:
        """
        
        aws --no-sign-request s3 sync s3://sra-pub-run-odp/sra/${run} .
        if [ ! -f ${run} ] ; then
            echo "${study_accession}        ${run}" >> test.txt
            failure="FALSE"
        fi
        """
        
}
