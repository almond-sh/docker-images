FROM almondsh/almond:coursier

USER $NB_UID

ENV SCALA_VERSION 2.12.8
ENV ALMOND_VERSION 0.2.2

RUN coursier bootstrap \
      -r jitpack \
      -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
      sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
      --default=true --sources \
      -o almond && \
    ./almond --install --log info --metabrowse && \
    rm almond
