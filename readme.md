# Deprecated Notebook Container Images
This repository publishes lists of notebook container images that have been deprecated at each release of JupyterHub.

## Using Deprecated Images
We generally recommend updating your code to work with new notebook container images.

However, we realize this is not always practical and sometimes not possible, so we provide the following options to continue using the software contained in deprecated images:
1. Run the old notebook container image as a [batch job](https://csu-tide.github.io/batch-jobs)
    - *Note*: This option may require [requesting access to a namespace](https://csu-tide.github.io/batch-jobs/getting-access) and migrating your data
    - *Note*: You may use the kubernetes recipe for scheduling an [interactive JupyterLab session](https://github.com/csu-tide/k8s-recipes/tree/master/jupyter) via batch job
1. Attempt to recreate the conda environments in the new notebook container image
    - *Note*: This option may be difficult for users that are new to [environment management](https://csu-tide.github.io/jupyterhub/environment-management)
    - *Note*: This option will consume storage in your persistent home directory, so we recommend checking your [disk quota](https://csu-tide.github.io/jupyterhub/faqs/diskquota) before and after recreating these environments

Both of these options come with tradeoffs to consider.
Running a batch job will work, but it will require learning a bit about Kubernetes batch job scheduling and transferring data into a namespace.
Recreating an environment may be difficult and ultimately may not work if packages are not available and it will consume your persistent home directory storage.

### Running deprecated notebook container images via batch job
Follow these steps to run a deprecated notebook container image as an interactive JupyterLab session via batch job:
1. If you do not have access to a namespace, [request access](https://csu-tide.github.io/batch-jobs/getting-access)
1. If you do not have storage in your namespace, [request storage](https://csu-tide.github.io/storage-services/requesting-storage)
    - *Note*: You may request access and storage in the same request if you are requesting both for the first time
1. If you have not completed it yet, proceed through the [getting started guide](https://csu-tide.github.io/batch-jobs/getting-started)
1. Follow the [Interactive Jupyter Lab](https://github.com/csu-tide/k8s-recipes/tree/master/jupyter) kubernetes recipe, swapping out the image as described in Prep step 4 with the image you wish to use
1. Proceed through the rest of the steps in the Interactive JupyterLab recipe

### Recreating conda environments from deprecated notebook container images
Follow these steps to try recreating the conda environment from the relevant environment file.
    - *Note*: This option is not guaranteed to work as software may no longer be available from the relevant package repositories
    - *Note*: We recommend referring to ours docs on [environment management](https://csu-tide.github.io/jupyterhub/environment-management)

1. Download the environment file for the image you wish to use into your JupyterHub home directory
2. Activate your base environment:
```bash
source activate base
```
3. Recreate the environment from file:
```bash
mamba env create -f environment.yaml -p ~/[env-name]
```
- *Note*: We recommend mamba over conda for environment creation due to is speedier dependency solver
4. Address issues as they arise, repeating step 1 as appropriate
    - *Note*: This may involve updating and/or removing packages from the environment file
5. If the conda environment is created, and pip is the only issue, then activate the new environment via:
```bash
conda activate ~/[env-name]
``` 
6. Continue troubleshooting pip issues from inside the environment

## Deprecated as of JupyterHub release 2025-03-13
| Display Name                  | Env File(s)                                        | Image URL                                                                                             |
| ----------------------------- | ------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| Stack Minimal                 | [minimal_v1_3-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/minimal_v1_3-base.yaml) | gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/minimal:v1.3 |
| Stack R                       | [r_v1_3-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/r_v1_3-base.yaml)            | gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/r:v1.3  |
| Stack Scipy                   | [scipy_v1_3-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/scipy_v1_3-base.yaml)    | gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/scipy:v1.3 |
| Stack Tensorflow              | [tensorflow_v1_3-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/tensorflow_v1_3-base.yaml) | gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/tensorflow:v1.3 |
| Stack Datascience             | [datascience_v1_3-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/datascience_v1_3-base.yaml) | gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/datascience:v1.3 |
| Stack PRP                     | [prp_v1_3-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/prp_v1_3-base.yaml)        | gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/prp:v1.3 |
| R Studio Server               | [r-studio_v1_3-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/r-studio_v1_3-base.yaml)  | gitlab-registry.nrp-nautilus.io/prp/jupyter-stack/r-studio:v1.3 |
| GIS Notebook                  | [gis_research-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/gis_research-base.yaml) | ghcr.io/sdsu-research-ci/gis-notebook@sha256:59f8b4f88f611605a21d5ad3e0e554e57d108e1e3854d4c379ac960a94614f90 |
| Health Informatics Notebook   | [biopython_research-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/biopython_research-base.yaml) | ghcr.io/sdsu-research-ci/biopython-notebook@sha256:04f58a631865d5828ee568ca438eb65d2276380b1bd171bbdb8d90b3d9c250da |
| LLM Notebook                  | [llm_v1_8-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/llm_v1_8-base.yaml); [llm_v1_8-llm.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/llm_v1_8-llm.yaml) | kkricksdsu/llm-notebook:v1.8 |
| Astronomy Notebook            | [astro_v1_5-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/astro_v1_5-base.yaml)    | kkricksdsu/astro-notebook:v1.5 |
| Kaya Notebook                 | [kaya_v1_1-base.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/kaya_v1_1-base.yaml); [kaya_v1_1-torch_amr.yaml](https://github.com/kkrick-sdsu/conda-envs/blob/main/kaya_v1_1-torch_amr.yaml) | kkricksdsu/kaya-notebook:v1.1 |
