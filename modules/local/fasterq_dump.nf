process FASTERQ_DUMP {
    tag 'high'

    errorStrategy  { task.attempt <= maxRetries  ? 'retry' :  'ignore' }

    input:
        file run

    output:
        file "*.fastq"

    script:
        """
        fasterq-dump -f -p -e 8 --split-files --skip-technical ${run} --temp /data2/Jack/temp
        """
}