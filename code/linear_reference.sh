

# mapping sequencing reads
bwa index ref.fa
bwa mem ref.fa read1.fq read2.fq > aln-pe.sam

