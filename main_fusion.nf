#!/usr/bin/env nextflow

/*
* nextflow_rnaseqfusion - A tumor whole transcriptome sequencing pipelines based on nextflow
*/

/*
* General Paramters 
*/

nextflow.enable.dsl = 2

log.info """\
======================================================================
Whole transcriptome sequencing TUMOR
======================================================================
outdir                  :       $params.outdir
subdir                  :       $params.subdir
crondir                 :       $params.crondir
csv                     :       $params.csv
=====================================================================
"""

/*
Include the subworkflow
*/
include { subSampleWorkflow } from './subworkflow/SubSample/main.nf'

Channel
    .fromPath(params.csv)
    .splitCsv(header:true)
    .map{ row-> tuple(row.id, file(row.read1), file(row.read2)) }
    .set {fileInfo}

println(fileInfo)
sampleReads = params.subsampling_number

workflow {
    subSampleWorkflow (sampleReads, fileInfo)
}

