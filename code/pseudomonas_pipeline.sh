

## how to run 
## pseudomonas_pipeline.sh ref_genome  assembly_dir reads_dir

ref_fa=$1
assembly_dir=$2
reads_dir=$3

## linear reference
bwa index ${ref_fa}
for reads in $(ls -1 ${reads_folder}); do
bwa mem ${ref_fa} ${reads} > ${reads}
samtools view -hb ${reads} >${reads}.bam
Picard CollectMultipleMetrics ${ref_fa}-index.tar.gz ${reads}.bam
done



## graph reference

cat ${assembly_dir}/*.fa > AssembliesForTesting.fa 
bgzip AssembliesForTesting.fa
samtools faidx AssembliesForTesting.fa.gz

# Create the graph genome - this may take hours to days depending on size
pggb -i AssembliesForTestingRe.fa.gz -o . -t 16 -n 5 -p 90 -s 5000

# Create a file with sample names
for i in ${reads_dir}/*1.fastq.gz ; do echo ${i/_1.fastq.gz/} >> samples.txt ;done

# Run GraphAligner with 5 assembly graph genome for samples 1-30 downloaded 
for i in $(cat samples.txt) ; do echo $i ; GraphAligner -g 5AssembliesForTestingRe.fa.gz.fd8c760.417fcdf.11fe66b.smooth.final.gfa -f ${i}_1.fastq.gz -f ${i}_2.fastq.gz -a ${i}_5assemblieswre.gam; done

# Extracting stats
for i in $( ls -1 ./*gam); do echo $i; vg stats -a $i >> ${i}_5assemblies.vgstats; done


