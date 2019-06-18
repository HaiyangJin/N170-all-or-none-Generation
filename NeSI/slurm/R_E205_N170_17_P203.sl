#!/bin/bash
#SBATCH --job-name=32N117     # job name (shows up in the queue)
#SBATCH --account=uoa00424     # Project Account
#SBATCH --time=1-00:10:00         # Walltime (HH:MM:SS)
#SBATCH --mem-per-cpu=1500      # memory/cpu (in MB)
#SBATCH --ntasks=1              # number of tasks (e.g. MPI)
#SBATCH --cpus-per-task=1       # number of cores per task (e.g. OpenMP)
#SBATCH --partition=large        # specify a partition
#SBATCH --hint=nomultithread    # don't use hyperthreading
#SBATCH --mail-type=END
#SBATCH --mail-user=hjin317@aucklanduni.ac.nz
#SBATCH --output=P203/R_E2_N170_17_P203_%j.out # Include the job ID in the names of

module load R

# Help R to flush errors and show overall job progress by printing
# "executing" and "finished" statements.
echo "Executing R ..."
srun Rscript P203/NeSI_lmm_E2_N170_17_P203.R
echo "R finished."
 