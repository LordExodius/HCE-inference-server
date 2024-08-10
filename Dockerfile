FROM tensorflow/serving

ENV MODEL_PATH=models/ssd_mobilenet_v2_320x320_coco17_tpu-8/saved_model
ENV MODEL_NAME=ssd_mobilenet_v2
ENV MODEL_RELOAD_TIMEOUT=60
ENV ENABLE_DEBUG=0
ENV MODEL_CONFIG=models

WORKDIR /code

COPY ./models /code/models
COPY ./deployment.sh /code/deployment.sh
COPY ./.env /code/.env

RUN chmod 777 /code/deployment.sh
ENTRYPOINT []

CMD ["/code/deployment.sh"]