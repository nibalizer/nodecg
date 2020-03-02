FROM node:10

#npm install nodecg-cli
#nodecg setup
#<install bundles>
#<install bundle dependencies>
#<config file management>
WORKDIR /usr/src/app

# Copy NodeCG (just the files we need)
RUN mkdir cfg && mkdir bundles && mkdir logs && mkdir db
COPY . /usr/src/app/

# Not installing dependencies because they are installed in the wrapper script
#RUN npm install --production

# The command to run
EXPOSE 9090
CMD ["node", "index.js"]
