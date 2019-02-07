FROM almondsh/almond:coursier

USER $NB_UID

ENV SCALA_VERSION {SCALA_VERSION}
ENV ALMOND_VERSION {VERSION}

RUN coursier bootstrap \
      -r jitpack \
      -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
      sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
      --default=true --sources \
      -o almond && \
    ./almond --install --log info --metabrowse && \
    rm almond
