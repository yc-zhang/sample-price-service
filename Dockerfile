FROM alpine

MAINTAINER yc <turalyon.zhangyc@gmail.com>
RUN adduser -D yc-dojo

RUN mkdir /app
WORKDIR /app
ADD ./main /app/

RUN chown -R yc-dojo /app
USER yc-dojo

EXPOSE 8080
CMD ["./main"]
