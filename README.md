# HCE Inference Server

This repository contains the files necessary to deploy a standalone inference server via Docker using Tensorflow Serving as part of the Hybrid Cloud Edge application framework described in this [thesis](./README.md).

It contains a copy of SSD MobileNetV2 pre-trained on the [COCO 2017](./README.md) dataset, obtained from the [TF2 Detection Model Zoo](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/tf2_detection_zoo.md).

## Usage
### Basic Setup
To start, make sure you have Docker Desktop installed on the target for deployment.
1. Clone this repo using `git clone <placeholder>`
2. Navigate to the root directory `/HCE-inference-server/`
3. Run `make deploy`

> [!IMPORTANT]
> If you encounter a build error during `make deploy`, run `make clean` or use the Docker Desktop GUI to remove the container before attempting to restart the process.

> [!NOTE]
> The `serving` subdirectory is provided for convenience here, and may not be in sync with the most recent version. You can manually update this by running `make armegeddon` before either of the deploy commands to remove the subdirectory and ensure a clean, updated copy is cloned.

### Configuration
This inference server supports hot-swappable models via Tensorflow Serving. No automated script currently exists for automating the process, but may be added in future releases.

To enable live-reloading of the Model Server configuration, deploy the inference server using `make deploy-config`. This will instruct the server to check for a new config file periodically, allowing you to add or update models by simply updating `models.config` located in the `models` directory.

#### Example:
To upload a fine-tuned version of the SSD MobileNetV2 model, save the updated model to `models/ssd_mobilenet_v2_320x320_coco17_tpu-8/saved_model/<version_number>`, where `<version_number>` is greater than the existing version(s) and the server will automatically deploy the latest model after a period of time.

### Enabling Remote Model Updates
We can enable remote updates of the inference model by replacing the `/models` directory with a `git` submodule, and running a script to periodically call `git submodule update`.