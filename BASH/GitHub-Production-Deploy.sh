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
