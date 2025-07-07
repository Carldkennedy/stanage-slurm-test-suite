# Stanage SLURM Test Suite

A complete SLURM test suite for post-upgrade verification on the Stanage cluster.

## Usage

```bash
./run_tests.sh
```

Each job script is tailored to test features like:

- Array jobs
- Dependencies
- GPU requests
- SLURM environment
- Resource limits
- Signal traps
- Exit code tracking
