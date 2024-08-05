include .env

deploy:
	docker pull tensorflow/serving
	if test -d serving; then echo "already cloned"; else git clone https://github.com/tensorflow/serving; fi

	docker run \
	--name tf-serving \
	-p 8501:8501 \
	-v "$(shell pwd)/$(MODEL_PATH):/models/$(MODEL_NAME)" \
	-e MODEL_NAME=$(MODEL_NAME) \
	-e TF_CPP_VMODULE=http_server=$(ENABLE_DEBUG) \
	-t tensorflow/serving &

deploy-config:
	docker pull tensorflow/serving
	if test -d serving; then echo "already cloned"; else git clone https://github.com/tensorflow/serving; fi

	docker run \
	--name tf-serving \
	-p 8501:8501 \
	-v "$(shell pwd)/$(MODEL_PATH):/models/$(MODEL_NAME)" \
	-v "$(shell pwd)/$(MODEL_CONFIG)/models.config:/models/models.config" \
	-e TF_CPP_VMODULE=http_server=$(ENABLE_DEBUG) \
	-t tensorflow/serving \
	--model_config_file=/models/models.config \
	-model_config_file_poll_wait_seconds=$(MODEL_RELOAD_TIMEOUT)

docker-armageddon:
	docker container rm -f tf-serving

armageddon:
	docker container rm -f tf-serving
	rm -rf ./serving/