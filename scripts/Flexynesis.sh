#!/usr/bin/env bash
# Flexynesis.sh
# Usage: bash scripts/Flexynesis.sh



# create an environment with python 3.11 
mamba create --name flexynesisenv python==3.11
mamba activate flexynesisenv
# install latest version from pypi (https://pypi.org/project/flexynesis)
# make sure to use python3.11*
python -m pip install flexynesis --upgrade  


# Get Data
mkdir data 
cd data
wget "https://bimsbstatic.mdc-berlin.de/akalin/buyar/flexynesis-benchmark-datasets/ccle_vs_gdsc.tgz"
tar -xzvf ccle_vs_gdsc.tgz
cd ../


# Set the data path and target variable
DATA_PATH="data/ccle_vs_gdsc/"
TARGET_VARIABLE="Erlotinib"
HPO_ITER=15  


# Set output directory
cd ../
OUTPUT_DIR="results/"
mkdir -p "$OUTPUT_DIR"
mkdir $OUTPUT_DIR/GNN $OUTPUT_DIR/DirectPred


# Define architectures to test
ARCHITECTURES=("DirectPred" "GNN")

# Define data types to test
DATA_TYPE_COMBINATIONS=("mutation" "mutation,rna" "mutation,cnv")
FUSION_METHODS=("early" "intermediate")

# Set default GNN convolution type
GNN_CONV="GC"  # Default GNN Convolution type is GC

# Define feature filtering options
FEATURE_FILTERS="--variance_threshold 1 --features_top_percentile 5"



# Loop over architectures
for ARCH in "${ARCHITECTURES[@]}"; do
    # Loop over data type combinations
    for DATA_TYPES in "${DATA_TYPE_COMBINATIONS[@]}"; do
        # Skip intermediate fusion for GNN
        if [ "$ARCH" == "GNN" ]; then
            FUSION_METHODS=("early")
        fi

        # Loop over fusion methods
        for FUSION in "${FUSION_METHODS[@]}"; do
            # Handle GNN case: use default GNN_CONV type 'GC'
            if [ "$ARCH" == "GNN" ]; then
                flexynesis --data_path "$DATA_PATH" \
                           --model_class "$ARCH" \
                           --target_variables "$TARGET_VARIABLE" \
                           --data_types "$DATA_TYPES" \
                           --fusion "$FUSION" \
                           --hpo_iter "$HPO_ITER" \
                           $FEATURE_FILTERS \
                           --prefix "$OUTPUT_DIR/experiment_${ARCH}_${DATA_TYPES}_${FUSION}_${GNN_CONV}" \
                           --outdir "$OUTPUT_DIR/${ARCH}
                           
            else
                flexynesis --data_path "$DATA_PATH" \
                           --model_class "$ARCH" \
                           --target_variables "$TARGET_VARIABLE" \
                           --data_types "$DATA_TYPES" \
                           --fusion "$FUSION" \
                           --hpo_iter "$HPO_ITER" \
                           $FEATURE_FILTERS \
                           --prefix "$OUTPUT_DIR/experiment_${ARCH}_${DATA_TYPES}_${FUSION}" \
                           --outdir "$OUTPUT_DIR/${ARCH}
                           
            fi
        done
    done
done

echo "All experiments completed. Results are saved in '$OUTPUT_DIR'."