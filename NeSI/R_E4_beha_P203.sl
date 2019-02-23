#!/bin/bash
#SBATCH --job-name=R_P203     # job name (shows up in the queue)
#SBATCH --account=uoa00424     # Project Account
#SBATCH --time=12:00:00         # Walltime (HH:MM:SS)
#SBATCH --mem-per-cpu=8G      # memory/cpu (in MB)
#SBATCH --ntasks=1              # number of tasks (e.g. MPI)
#SBATCH --cpus-per-task=2       # number of cores per task (e.g. OpenMP)
#SBATCH --partition=large        # specify a partition
#SBATCH --hint=nomultithread    # don't use hyperthreading
#SBATCH --mail-type=END
#SBATCH --mail-user=hjin317@aucklanduni.ac.nz
#SBATCH --output=P203/R_E4_beha_P203_%j.out # Include the job ID in the names of

module load Rstudio/1.1.456
srun Rscript P203/NeSI_lmm_E4_beha_P203.R
