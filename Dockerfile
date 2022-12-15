ARG os=8.7.20221112
FROM aursu/rpmbuild:${os}-build

USER root

RUN dnf -y install \
        zlib-devel \
    && dnf clean all && rm -rf /var/cache/dnf

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "GeoIP.spec"]
CMD ["-ba"]
