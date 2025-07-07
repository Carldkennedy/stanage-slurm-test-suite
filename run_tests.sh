#!/bin/bash
set -euo pipefail

log_file="test_slurm_$(date '+%Y-%m-%d_%H-%M-%S').log"

log() {
    echo -e "\n[$(date '+%F %T')] === $1 ===" | tee -a "$log_file"
}

WORKDIR=$(mktemp -d /tmp/stanage-slurm-test.XXXX)

log "0. Compiling hello.c"
module load OpenMPI/4.1.4-GCC-12.2.0
mpicc -o hello hello.c || { log "Compilation failed"; exit 1; }
cp job_*.sh trap.sh hello hello.c "$WORKDIR"

cd "$WORKDIR"
log "Running tests in $WORKDIR"
module load OpenMPI/4.1.4-GCC-12.2.0

# Submit all independent jobs
for script in job_basic.sh job_array.sh job_res.sh job_gpu_A.sh job_gpu_H.sh job_env.sh job_fail.sh job_mpi_hello.sh; do
    jid=$(sbatch --parsable "$script" | cut -d ";" -f 1)
    log "Submitted $script as JobID $jid"
done

# Submit job_a + dependent job_b
jid_a=$(sbatch --parsable job_a.sh | cut -d ";" -f 1)
jid_b=$(sbatch --parsable --dependency=afterok:$jid_a job_b.sh | cut -d ";" -f 1)
log "Submitted job_a.sh as $jid_a and job_b.sh with dependency as $jid_b"

# Signal trap
chmod +x trap.sh
jid_trap=$(sbatch --parsable --signal=TERM@30 --output=trap.out ./trap.sh | cut -d ";" -f 1)
log "Submitted trap.sh as JobID $jid_trap — will cancel after 5s"
sleep 5 && scancel "$jid_trap"
log "Cancelled trap job"

# Wait and report
log "Sleeping 90s before status checks..."
sleep 90

log "Job status summary from sacct:"
sacct -S now-1hour --format=JobID,JobName%20,State,ExitCode

log "Waiting for jobs to finish..."
while squeue --me | grep -q -E "$jid_a|$jid_b|$jid_trap"; do
    sleep 10
done

log "Output preview (first 40 lines per job):"
find . -name "*.out" -exec head -n 40 {} \; | tee -a "$log_file"

cd /
rm -rf "$WORKDIR"
log "Cleaned up $WORKDIR"

