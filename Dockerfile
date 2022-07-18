FROM nodered/node-red:latest
ARG NR_DB_URL
ARG NR_APP_ID
ARG NR_DB_USER
ARG NR_DB_PASS
ARG NR_DB_HOST
ARG NR_NAMESPACE
ARG NR_TYPE
ARG NR_IP
ENV IP=${NR_IP}
ENV NRNS=${NR_NAMESPACE}
ENV DBUSER=${NR_DB_USER}
ENV DBPASS=${NR_DB_PASS}
ENV DBHOST=${NR_DB_HOST}
ENV DBURL=${NR_DB_URL}
ENV APPID=${NR_APP_ID}
#    mongoURI: process.env.DBURL ||  + "mongodb+srv://" + process.env.DBUSER + ":" + process.env.DBPASS + "@cluster0." + process.env.DBHOST + ".mongodb.net/nrServer" ,


USER root
RUN chown -R node-red:root /data
#RUN echo "192.168.33.11    mynginx" >> /etc/hosts

USER node-red
WORKDIR /data
#COPY ./package.json /data/
#RUN npm install
#COPY package.json .
COPY $NR_TYPE ./package.json
#RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production
RUN npm install
WORKDIR /usr/src/node-red

RUN npm install --no-fund --no-update-notifier --save node-red-contrib-storage-mongodb
COPY settings.js /data/
COPY flows.json  /data/flows.json
USER root
#RUN chmod ugo+rw /data/package.json
RUN chown -R node-red:root /data/package.json
#RUN chmod ugo+rw /data/flows.json
RUN chown -R node-red:root /data/flows.json
RUN chown -R node-red:root /data/settings.js
USER node-red

# Env variables

    
#RUN npm install --no-fund --no-update-notifier --save node-red-mongo-storage-plugin
ENTRYPOINT npm start --  --userDir /data
#CMD ["npm", "start"]

