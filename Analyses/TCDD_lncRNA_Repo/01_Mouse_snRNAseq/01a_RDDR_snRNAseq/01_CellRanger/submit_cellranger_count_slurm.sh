dirname=${1}
B=$(basename ${dirname})
F=${dirname}
n=$B

echo $B
echo $F
echo $n

sbatch --job-name=$n --output=$n.SLURMout --error=$n.SLURMerr --export=name=$n,sampleid=$B,in_path=$F /mnt/ufs18/home-183/cholicog/Jupyter_Notebooks/Working_lncRNA/01_Mouse_snRNAseq/02b_RDDR_snRNAseq/01_CellRanger/CellrangerCount_slurm.sbatch

echo 'Submitted'

