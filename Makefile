include .env

deploy:
	docker pull tensorflow/serving

	docker run \
	--name hce-inference-server \
	-p $(HOST_REST_PORT):8501 \
	-v "$(shell pwd)/$(MODEL_PATH):/models/$(MODEL_NAME)" \
	-e MODEL_NAME=$(MODEL_NAME) \
	-e TF_CPP_VMODULE=http_server=$(ENABLE_DEBUG) \
	-t tensorflow/serving &

deploy-config:
	docker pull tensorflow/serving

	docker run \
	--name hce-inference-server \
	-p $(HOST_REST_PORT):8501 \
	-v "$(shell pwd)/$(MODEL_PATH):/models/$(MODEL_NAME)" \
	-v "$(shell pwd)/$(MODEL_CONFIG)/models.config:/models/models.config" \
	-e TF_CPP_VMODULE=http_server=$(ENABLE_DEBUG) \
	-t tensorflow/serving \
	--model_config_file=/models/models.config \
	-model_config_file_poll_wait_seconds=$(MODEL_RELOAD_TIMEOUT)

clean:
	docker container rm -f hce-inference-server

build:
	docker build -t hce/inference-server .

armageddon:
	docker container rm -f hce-inference-server
	rm -rf ./serving/