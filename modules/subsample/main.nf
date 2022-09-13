process SUBSAMPLE {

// This generic subsample module using generic seqtk package based on expected number of reads to be subsmpled. See more here (https://github.com/lh3/seqtk). Currently default number of reads is 65M (65000000). 

input: 
    tuple val(ReadNum),
    val(SampleID), 
    path (read1), 
    path (read2)

output:
    tuple val(SampleID),
    path (${SampleID}_read1_sub.fastq.gz), 
    path (${SampleID}_read2_sub.fastq.gz)

script:

"""
n_reads=$(zcat ${read1} | grep  '@'|wc -l) 
echo "Number of reads: ${n_reads}" 

if  (("$n_reads" > ${ReadNum} )); then 
    seqtk sample s100 ${read1} ${ReadNum} > read1_sub.fastq
    seqtk sample s100 ${read2} ${ReadNum} > read2_sub.fastq
    
    gzip read1_sub.fastq
    gzip read2_sub.fastq 

    mv  read1_sub.fastq.gz  ${SampleID}_read1_sub.fastq.gz
    mv  read2_sub.fastq.gz  ${SampleID}_read2_sub.fastq.gz
    
else
    mv ${read1} ${SampleID}_read1_sub.fastq.gz
    mv ${read1} ${SampleID}_read2_sub.fastq.gz
fi

"""
}