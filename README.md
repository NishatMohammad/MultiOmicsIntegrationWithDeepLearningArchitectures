# ANALYSIS OF ERLOTINIB RELATED BIOMARKERS THROUGH MULTI-OMICS INTEGRATION AND DEEP LEARNING ARCHITECHTURES FROM FLEXYNESIS

## Introduction
Erlotinib is a targeted cancer therapy primarily used to treat non-small cell lung cancer (NSCLC) and pancreatic cancer. It functions as an epidermal growth factor receptor (EGFR) inhibitor, slowing down or stopping the proliferation of cancer cells that harbor EGFR mutations. Despite its effectiveness, resistance to Erlotinib often emerges through additional mutations in EGFR (like T790M) or alternative signaling mechanisms such as KRAS mutations.

## Methods and Materials
This study utilized the **Flexynesis** Python package, developed by MDC Berlin's Computational Biology team, for multi-omics integration and machine learning-based biomarker identification. I followed the official [Flexynesis documentation](https://bimsbstatic.mdc-berlin.de/akalin/buyar/flexynesis/site/getting_started/#compiling-notebooks) to perform command-line execution and model training.

### Data Sources:
- **CCLE and GDSC datasets**: Multi-omics data from human cancer cell lines ([Dataset Link](https://bimsbstatic.mdc-berlin.de/akalin/buyar/flexynesis-benchmark-datasets/ccle_vs_gdsc.tgz))
- **Broad Institute CCLE Data**: [CCLE Data](https://sites.broadinstitute.org/ccle/)
- **GDSC Drug Sensitivity Data**: [GDSC Data](https://www.cancerrxgene.org/)

### Model Training and Benchmarking:
- Built models on CCLE data and evaluated them on GDSC.
- Tested multiple deep learning architectures:
  - **DirectPred**, **Graph Neural Networks (GNNs)**
- Integrated multi-omics data:
  - **Mutation**, **RNA expression**, **Copy Number Variation (CNV)**
- Applied feature selection using **variance** and **Laplacian score filtering**.
- Benchmarked different fusion methods: **early fusion** and **intermediate fusion** (except GNNs, which only support early fusion).

## Results
- Identified top 10 biomarkers associated with Erlotinib sensitivity, including **KRAS, EGFR, ACSL5, and TMPRSS4**.
- IntegratedGradients feature importance analysis highlighted KRAS and EGFR mutations as key determinants of drug response.
- Different machine learning architectures yielded varying predictive performance, with **DirectPred** showing the highest accuracy.

## Discussion
- **KRAS and EGFR** mutations are well-established resistance markers to Erlotinib, confirming literature findings.
- Biomarkers such as **S100A2 and FA2H** require further investigation to validate their roles in drug response.
- Multi-omics data integration improves predictive power, highlighting the necessity of multi-layered analyses in precision oncology.

## Future Directions
- Further validation of novel biomarkers using additional datasets and experimental validation.
- Testing additional machine learning architectures such as transformers for improved performance.
- Expanding the dataset to include clinical samples for enhanced translational relevance.

## References
1. Serizawa, M., Takahashi, T., Yamamoto, N., & Koh, Y. (2013). Genomic aberrations associated with Erlotinib resistance in non-small cell lung cancer cells. *Anticancer Research, 33*(12), 5223-5233.
2. Brugger, W., Triller, N., Blasinska-Morawiec, M., et al. (2011). Prospective molecular marker analyses of EGFR and KRAS from a randomized, placebo-controlled study of Erlotinib maintenance therapy in advanced non–small-cell lung cancer. *Journal of Clinical Oncology, 29*(31), 4113-4120. https://doi.org/10.1200/JCO.2010.33.1601
3. [Flexynesis Documentation](https://bimsbstatic.mdc-berlin.de/akalin/buyar/flexynesis/site/getting_started/)
4. [CCLE Data](https://sites.broadinstitute.org/ccle/)
5. [GDSC Data](https://www.cancerrxgene.org/)

