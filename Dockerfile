FROM nodered/node-red:latest
ARG NR_DB_URL
ARG NR_APP_ID
ARG NR_DB_USER
ARG NR_DB_PASS
ARG NR_DB_HOST
ARG NR_NAMESPACE
ENV NRNS=${NR_NAMESPACE}
ENV DBUSER=${NR_DB_USER}
ENV DBPASS=${NR_DB_PASS}
ENV DBHOST=${NR_DB_HOST}
ENV DBURL=${NR_DB_URL}
ENV APPID=${NR_APP_ID}
#    mongoURI: process.env.DBURL ||  + "mongodb+srv://" + process.env.DBUSER + ":" + process.env.DBPASS + "@cluster0." + process.env.DBHOST + ".mongodb.net/nrServer" ,


USER root
RUN chown -R node-red:root /data
USER node-red
WORKDIR /usr/src/node-red
RUN npm install --no-fund --no-update-notifier --save node-red-contrib-storage-mongodb
COPY settings.js /data/
COPY flows.json  /data/flows.json
# Env variables

    
#RUN npm install --no-fund --no-update-notifier --save node-red-mongo-storage-plugin
ENTRYPOINT npm start --  --userDir /data
#CMD ["npm", "start"]

