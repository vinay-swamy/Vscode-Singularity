# Vscode-Singularity
Run VScode in a singularity container so that it can be contained on `/pmglocal` on manitou.

Build container from docker file and push to dockerhub. Then run 

module load singularity
export SINGULARITY_CACHEDIR="/pmglocal/$USER/singularity_cache" 
export SINGULARITY_TMPDIR="/pmglocal/$USER/singularity_tmp"

```
cd /pmglocal/$USER
cp /burg/home/$USER/vs_bashrc .bashrc
cp /burg/home/$USER/vs_bash_profile .bash_profile
cp /burg/home/$USER/lmod_src.sh .
singularity pull vscode.sif docker://vinayswamy/vscodecli:latest ## only need to pull this once per node 
singularity exec --nv -H /pmglocal/$USER/ -B /pmglocal/ -B /manitou -B /burg -B /cm vscode.sif code tunnel --cli-data-dir /pmglocal/$USER/vscode/ --accept-server-license-terms
```

VScode runs without error using this method, but one issue  is that loadable modules(`module load ...`) are not available. A work around is to add the following to your bashrc 

```
source /pmglocal/$USER/lmod_src.sh
# User specific aliases and functions
export PATH="$PATH:/cm/local/apps/environment-modules/4.5.3/bin:/cm/shared/apps/slurm/current/sbin:/cm/shared/apps/slurm/current/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/cm/shared/apps/slurm/current/lib64/slurm:/cm/shared/apps/slurm/current/lib64"
```
