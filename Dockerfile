FROM almondsh/almond:coursier

USER $NB_UID

ARG ALMOND_VERSION

# Set to a single Scala version string or list of Scala versions separated by a space.
# i.e SCALA_VERSIONS="2.11.12 2.12.8"
ARG SCALA_VERSIONS

RUN [ -z "$SCALA_VERSIONS" ] && echo "SCALA_VERSIONS is empty" && exit 1; \
    [ -z "$ALMOND_VERSION" ] && echo "ALMOND_VERSION is empty" && exit 1; \
    for SCALA_FULL_VERSION in $SCALA_VERSIONS; do \
        # remove patch version
        SCALA_MAJOR_VERSION=${SCALA_FULL_VERSION%.*}; \
        # remove all dots for the kernel id
        SCALA_MAJOR_VERSION_TRIMMED=$(echo $SCALA_MAJOR_VERSION | tr -d .); \
        echo Installing almond $ALMOND_VERSION for Scala $SCALA_FULL_VERSION; \
        coursier bootstrap \
            -r jitpack \
            -i user -I user:sh.almond:scala-kernel-api_$SCALA_FULL_VERSION:$ALMOND_VERSION \
            sh.almond:scala-kernel_$SCALA_FULL_VERSION:$ALMOND_VERSION \
            --default=true --sources \
            -o almond && \
        ./almond --install --log info --metabrowse --id scala$SCALA_MAJOR_VERSION_TRIMMED --display-name "Scala $SCALA_MAJOR_VERSION" && \
        rm -f almond; \
    done
