FROM timbru31/ruby-node:2.7-slim-14

WORKDIR /opt/app

COPY . .

RUN npm install --production

EXPOSE 3000

ENTRYPOINT npm start
