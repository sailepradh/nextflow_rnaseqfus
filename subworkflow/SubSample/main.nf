/*
Import modules according to the subworkflow of the RNA pipelines
*/

include { SUBSAMPLE } from '../../modules/subsample/main.nf'

workflow subSampleWorkflow {
    take:
        sampleReads
        fileInfo
    main:
        // def input = readNumber.combine(sampleInfo)
        SUBSAMPLE (sampleReads, fileInfo)

    emit:
        subSample = SUBSAMPLE.out
}