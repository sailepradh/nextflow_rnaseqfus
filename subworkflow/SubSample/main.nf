/*
Import modules

*/

include {SUBSAMPLE} from '../../modules/subsample/main.nf'

workflow subsample_workflow {
    take:
        readNumber
        sampleInfo
    main:
        def input = readNumber.combine(sampleInfo)
        SUBSAMPLE (input)

    emit:
        subsmaple = SUBSAMPLE.out

}