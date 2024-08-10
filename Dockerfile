FROM tensorflow/serving

ENV MODEL_PATH=/models/ssd_mobilenet_v2_320x320_coco17_tpu-8/saved_model
ENV MODEL_NAME=ssd_mobilenet_v2
ENV MODEL_RELOAD_TIMEOUT=60
ENV ENABLE_DEBUG=0
ENV MODEL_CONFIG=models

WORKDIR /

COPY ./models /models
COPY ./deployment.sh /deployment.sh

RUN chmod 777 /deployment.sh
ENTRYPOINT []

CMD ["/deployment.sh"]