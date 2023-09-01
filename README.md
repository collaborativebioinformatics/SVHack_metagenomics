# SVHack_group3

<img src="https://github.com/collaborativebioinformatics/SVHack_metagenomics/assets/72709799/4a4ffcf6-d417-4efc-b2ed-ff0d4e8c7073" alt="Logo_v2" width="800"/>



# Impact of bacteria diversity on alignment accuracy for antibiotic resistant organisms


## Introduction
The rapid tracking of antibiotic resistance evolution has been revolutionised by high-throughput technologies in bacterial sequencing. To study the variations among different strains, prokaryotic pangenomics  has proven to be invaluable.

Pangenomics, a concept prominently observed in prokaryotic genomes, offers a comprehensive view of genetic diversity within a species by considering not only the core set of genes shared among all individuals, but also the accessory genes present in some members. Pangenomes acknowledge the genomic variability present in microbial populations and contribute to our understanding of their adaptability, evolution, and ecological niche specialisation. This approach contrasts with the traditional monoploid genome representation that might not capture the full diversity of a species.

Graph genomes have emerged as a powerful tool in the analysis of pangenomes. Graph genomes can represent both linear and non-linear genomic structures, providing a more flexible framework to model variations such as single nucleotide variants (SNVs), insertions, deletions, duplications, and rearrangements. For prokaryotes, graph genomes offer several advantages. They can capture strain-level variations more effectively, enabling a more accurate reconstruction of gene repertoires within a species. Graph genomes also facilitate the incorporation of diverse data sources like short-read and long-read sequencing data, enabling comprehensive variant calling and genotyping.

However, graph genomes also come with challenges. Constructing and navigating complex graph structures can be computationally intensive and require specialised algorithms. The trade-off between complexity and computational efficiency is a crucial consideration. Furthermore, while graph genomes excel at representing variable regions, they can complicate the representation of highly conserved genomic regions and lead to challenges in aligning sequences consistently. Additionally, tools and standards for graph genome analysis are still evolving, making analysis pipelines less standardised compared to linear genome analysis.

In summary, the use of graph genomes in prokaryotic pangenomics has revolutionised our understanding of microbial genetic diversity. The flexibility and accuracy they provide in modelling strain-level variations have the potential to enhance studies ranging from microbial evolution to host-pathogen interactions. As the field continues to develop, addressing the computational demands and refining analysis methodologies will be crucial for realising the full potential of graph genomes in prokaryotic research.

## Goal of project
Conventional comparative genomic analyses that solely rely on linear reference sequences can introduce biases rooted in reference sequences and potentially disregard the spectrum of population or strain diversity. To mitigate these limitations, we leverage the rich resource of genome assemblies derived from isolates. These assemblies will serve as the foundational elements for constructing graph genomes tailored to our target organism.

This research initiative aims to explore the intricate relationship between bacterial diversity and the precision of alignment methods for antibiotic-resistant organisms. For choosing an organism to analyse, we turned to the World Health Organization's list of global priority pathogens related to multidrug resistance. For this hackathon, our investigation centers on the significance of "Pseudomonas aeruginosa", an opportunistic Gram-negative bacterium that holds paramount clinical importance. Additionally, we might explore the Enterobacteriaceae family, if time constraints allow. Meanwhile, the bacterium Acinetobacter baumannii has already been extensively examined in prior studies, so it does not constitute our primary focus at this juncture.

Upon generating a graph genome, we will test it by comparing it to a traditional linear reference genome. Our study methodology involves a meticulous comparison of several critical parameters. We will perform alignments of multiple isolates not used for the generation of the graph genome, and then assess the quantity and quality of mapped reads, alongside computational factors such as processing time and memory utilisation, within both analytical pipelines. This comprehensive evaluation enables us to gain insights into the efficacy and computational efficiency of these pipelines, thereby contributing to a deeper understanding of alignment accuracy in the context of diverse bacterial populations.


## Methods


<img src="https://github.com/collaborativebioinformatics/SVHack_metagenomics/assets/72709799/3a43d8a7-0d69-445c-9b42-1489d31b82b3" alt="Flowchart" width="600"/>

## Details on the tasks at hand

![Flow_chart_Day1](https://github.com/collaborativebioinformatics/SVHack_metagenomics/assets/72709799/f22e93af-ff21-4df4-a173-1ed5422bc7b9)




#### Task A : Graph Genome Construction
| No. |Task  | Responsible Person | Link|
|:---: |:-------------: | :-------------: | :---: |
|Task A1 |Download genome assemblies full-length genome, diverse strains isolated from different environments (find assembly accession and make a metadata table).   | Tania, Tony||
|Task A2 |Constructing graph genome (find graph construction tools) e.g. minigraph. (using 5/20/100/500 assemblies). | Jason/ Tania, Shaheerah, Pedro ||
|Task A3 |Choose an aligner specific for graph genomes, and perform alignments. Alignments will be performed using the reads obtained in Task B.  | Astrid, Lorianne ||
|Task A4 |Choose a method for visualization and generating stats and use it. |  || 
|Task A5 |Calculate statistics from alignments (time/#aligned reads/quality distribution) |  ||
|Task A6 |Generate graph genome annotation (Optional). |  ||

#### Task B : Standard Genome Pipeline
| No. |Task  | Responsible Person | Link|
|:---: |:-------------: | :-------------: | :---: |
|Task B1 |Download reference genome. | Muhammad ||
|Task B2 |Download the illumina DNA sequencing reads (different biosamples than those used for the graph genome). | Muhammad ||
|Task B3 |Align reads to the reference genome from B1 using BWA MEM. | Shaheereh, Pedro ||
|Task B4 |Calculate statistics from alignments (time/#aligned reads/quality distribution). |  ||

### Read Mapping to Single Reference

60 Illumina sequencing datasets including *P. aeruginosa* (NCBI Taxonomy ID 287) reads were downloaded from the Sequence Read Archive (metadata for these samples is included in the linked GitHub repository - https://github.com/collaborativebioinformatics/SVHack_metagenomics/tree/2797b9eec54665258a67ef0277fbd4d06d4e26c7/reads_info). The reference sequence [NC_002516.2](https://www.ncbi.nlm.nih.gov/nuccore/NC_002516.2/) (Genome assembly ASM676v1) derived from the PA01 strain was also downloaded. BWA-MEM (ver. BWA-0.7.17 (r1188)) was used for short-read alignment to the reference genome for all 60 datasets. Quality control statistics were obtained from output files using samtools (ver. ). 

### Construction of Pangenome Graphs

Of 773 available assemblies, 499 complete *P. aeruginosa* genomes were downloaded from NCBI on 8/30/2023. Metadata for the included sequences is included in the linked GitHub repository - https://github.com/collaborativebioinformatics/SVHack_metagenomics/tree/2797b9eec54665258a67ef0277fbd4d06d4e26c7/assemblies_info. Pangenome graphs of varying sizes (5, 10, 20, 50, 100, 500 genomes) were created using the reference [NC_002516.2](https://www.ncbi.nlm.nih.gov/nuccore/NC_002516.2/) and complete genome assemblies such that all genomes in the smaller pangenome graphs are contained in the larger graphs. All pangenome graphs were created using the pggb tool (ver. 0.5.4 - Fatica) with default settings applied (pggb -i assembly.fasta.gz -o . -t 16 -n 5 -p 90 -s 5000).

### Read Mapping to the Pangenome

Similar to the single reference genome, reads were mapped to pangenome graphs using GraphAligner (v1.0.10) from the docker image [jmonlong/job-graphaligner:latest](https://hub.docker.com/layers/jmonlong/job-graphaligner/latest/images/sha256-c4f833ea8fd303dbe93872f962ff168684e4dbc5a23b4f844c1e4038d7685c3f?context=explore). Default values related to seeding and extension were used (-seeds-minimizer-count 5 --seeds-minimizer-length 19 --seeds-minimizer-windowsize 30 --seeds-minimizer-chunksize 100 -b 5 -B 10 -C 10000). Statistics related to alignment were extracted from resulting GAM files using vg (ver. 1.23.0) from docker image [biocontainers/vg](https://registry.hub.docker.com/r/biocontainers/vg).

# Results
We have proceeded to build graph representations for _Pseudomonas aeruginosa_ using 5, 10 and 20 genomes. As more assemblies are used, the graph grows in complexity and more regions of the genome are visibly accessories and not core. Observing the sequenced alignments of the 20 asssemblies used to create that graph, one can see big chunks of the sequences being absent from most of the different isolates, while others are present in all. 

![Results_graphs_Hackathon2023 (2)](https://github.com/collaborativebioinformatics/SVHack_metagenomics/assets/72709799/37bc20b3-b37c-49ba-bdfc-097842b67c6a)
![500AssembliesForTestingRe fa gz fd8c760 417fcdf 11fe66b smooth final og lay draw](https://github.com/collaborativebioinformatics/SVHack_metagenomics/assets/72709799/78c50f80-661b-4c40-b9d7-502915a4e3cb)
![500AssembliesForTestingRe fa gz fd8c760 417fcdf 11fe66b smooth final og viz_multiqc](https://github.com/collaborativebioinformatics/SVHack_metagenomics/assets/72709799/80fc43a3-f7b4-472c-babc-203ff70127bf)


# stats of aligning 60 samples (DNA seqeuencing read)  on the linear reference
![stats](https://github.com/collaborativebioinformatics/SVHack_metagenomics/blob/main/results/linear_ref.png)
![stats2](https://github.com/collaborativebioinformatics/SVHack_metagenomics/blob/main/results/linear_ref_perc.png)

