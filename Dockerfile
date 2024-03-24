FROM alpine

RUN apk add \
	alsa-lib \
	alsa-ucm-conf \
	alsa-utils \
	alsa-utils-doc \
	alsaconf \ 
	darkice \
	icecast

COPY ./startup.sh /bin/startup.sh
COPY ./config/darkice.cfg /etc/darkice.cfg
COPY ./config/icecast.xml /etc/icecast.xml
COPY ./config/alsa.conf /etc/asound.conf

EXPOSE 8000

ENTRYPOINT ["/bin/startup.sh"]