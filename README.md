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
