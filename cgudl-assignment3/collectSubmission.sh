#!/bin/bash
set -euo pipefail

CODE=(
	"cgudl/rnn_layers.py"
	"cgudl/transformer_layers.py"
	"cgudl/classifiers/rnn.py"
	"cgudl/net_visualization_pytorch.py"
	"cgudl/gan_pytorch.py"
	"cgudl/simclr/contrastive_loss.py"
	"cgudl/simclr/data_utils.py"
	"cgudl/simclr/utils.py"
)
NOTEBOOKS=(
	"RNN_Captioning.ipynb"
	"Transformer_Captioning.ipynb"
	"Network_Visualization.ipynb"
	"Generative_Adversarial_Networks.ipynb"
	"Self_Supervised_Learning.ipynb"
	"LSTM_Captioning.ipynb"
)

FILES=( "${CODE[@]}" "${NOTEBOOKS[@]}" )

LOCAL_DIR=`pwd`
ASSIGNMENT_NO=3
ZIP_FILENAME="a3.zip"

C_R="\e[31m"
C_G="\e[32m"
C_BLD="\e[1m"
C_E="\e[0m"

for FILE in "${FILES[@]}"
do
	if [ ! -f ${FILE} ]; then
		echo -e "${C_R}Required file ${FILE} not found, Exiting.${C_E}"
		exit 0
	fi
done

echo -e "### Zipping file ###"
rm -f ${ZIP_FILENAME}
zip -q "${ZIP_FILENAME}" -r ${NOTEBOOKS[@]} $(find . -name "*.py") -x "makepdf.py"

echo -e "### Creating PDFs ###"
python makepdf.py --notebooks "${NOTEBOOKS[@]}"

echo -e "### Done! Please submit a2.zip and the assignment3.pdf to Teams. ###"