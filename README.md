# sqs.sh
Record SLURM queue status in a CSV file

## Usage

Each time the script runs, it uses `squeue` and `sinfo` to gather some data, and adds it as a CSV line to `$OUTPUT`
