FROM timbru31/ruby-node:2.7-slim-14

ENV GIT_USER ""

WORKDIR /opt/app

COPY . .

RUN apt update && apt install -y git build-essential

RUN git config --global user.email "34319+kcdata-bot[bot]@users.noreply.github.com" && git config --global user.name "kcdata-bot[bot]"

RUN npm install --production

RUN cd ./script/kcdata-gen && bundle install

EXPOSE 3000

ENTRYPOINT npm start
