FROM library/alpine:3.11.3

ENV WORKDIR "/usr/src/twitch-tester"
WORKDIR ${WORKDIR}

RUN apk --update add --no-cache ffmpeg

RUN addgroup -g 1000 -S twitchTester && \
  adduser -u 1000 -S twitchTester -G twitchTester

COPY --chown=twitchTester:twitchTester twitch-tester.sh .
RUN chmod +x twitch-tester.sh

USER twitchTester

ENTRYPOINT [""]
CMD ["./twitch-tester.sh"]
