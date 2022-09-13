#!/usr/bin/env nextflow

/*
* nextflow_rnaseqfusion - A tumor whole transcriptome sequencing pipelines based on nextflow
*/

/*
* General Paramters 
*/


log.info """\
======================================================================
Whole transcriptome sequencing TUMOR
======================================================================
outdir                  :       $params.outdir
subdir                  :       $params.subdir
crondir                 :       $params.crondir
genome_fasta            :       $params.genome_fasta
csv                     :       $params.csv
=====================================================================
"""

/*
Include the subworkflow
*/

include {SUBSAMPLE} from '../../subworkflow/SubSample/main.nf'

Channel
    .fromPath(params.csv)
    .splitCsv(header:true)
    .map{ row-> tuple(row.id, file(row.read1), file(row.read2)) }
    .set (fileInfo)

println (fileInfo)

sampleReads = params.subsampling_number

workflow {
    subsample_workflow (sampleReads, fileInfo)
}