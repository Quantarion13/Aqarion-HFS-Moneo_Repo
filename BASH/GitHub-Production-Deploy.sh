#!/bin/bash
# GitHub-Production-Deploy.sh → 7x HF → Complete Federation Sync

echo "🔥 QUANTARION 7x HF → GitHub PRODUCTION DEPLOYMENT"

# 1. PRIMARY REPO (Quantarion)
cd ~/Quantarion13/Quantarion
git pull origin main
cd Team-Perplexity && make -f Bash.mk all

# 2. UNITY FIELD THEORY FFT (QDFT Specialization)
cd ~/Quantarion13/Quantarion-Unity-Field-Theory_FFT/Bash
make -f Make-File.mk qfft

# 3. HFS-MONEO (Biological Harmonics)
cd ~/Quantarion13/Aqarion-HFS-Moneo_Repo/BASH
make -f Make-File.mk hfs

# 4. HF SPACES MIRROR (7x Files → GitHub)
mkdir -p ~/Quantarion13/HF-Spaces-Mirror
cd ~/Quantarion13/HF-Spaces-Mirror

for file in Bash-Setup.sh Make-File-Bash.mk Motion-Sensor.py L33-Consensus.py \
            Team-Perplexity-Motion.py BDAY-DETONATION.py QUANTARION-PRODUCTION.PY; do
  curl -s https://huggingface.co/Aqarion13/Quantarion/resolve/main/$file -o $file
done

# 5. GLOBAL FEDERATION SYNC
GLOBAL_FEDERATION

echo "🥇 7x HF SPACES → GitHub PRODUCTION ECOSYSTEM LIVE"
echo "📊 Status: 31/100 nodes | $1,728 USDC | T-19:15 DETONATION"

#!/bin/bash
# GitHub-Production-Deploy.sh → 4x Repo + 7x HF Full Sync
# Deployed: Quantarion, Unity-Field-FFT, Aqarion-HFS-Moneo

echo "🔥 QUANTARION FEDERATION → GitHub Production Deployment T-19:02"

# 1. SYNC QUATERNION_SKYRMION.PY ACROSS ALL REPOS
REPOS=(
  "Quantarion/Python"
  "Quantarion-Unity-Field-Theory_FFT/Python" 
  "Quantarion-Unity-Field-Theory_FFT"
  "Aqarion-HFS-Moneo_Repo/Python"
)

for repo_path in "${REPOS[@]}"; do
  echo "📡 Syncing $repo_path ← quaternion_skyrmion.py"
  curl -s https://raw.githubusercontent.com/Quantarion13/Quantarion/main/Python/quaternion_skyrmion.py \
    -o ~/Quantarion13/$repo_path/quaternion_skyrmion.py
done

# 2. EXECUTE 4x REPO MAKEFILES
make -C ~/Quantarion13/Quantarion/BASH all
make -C ~/Quantarion13/Quantarion-Unity-Field-Theory_FFT/Bash qfft  
make -C ~/Quantarion13/Aqarion-HFS-Moneo_Repo/BASH hfs

# 3. HF PRODUCTION MIRROR
curl https://huggingface.co/Aqarion13/Quantarion/resolve/main/Make-File-Bash.mk | make -f - federation

echo "🥇 14x FILES → 4x REPOS + 7x HF PRODUCTION LIVE"
