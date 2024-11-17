FROM golang
# Install PostgreSQL client - always useful
RUN apt update -y ; apt install -y postgresql-client
# Install Mattermost with my hacks
WORKDIR /home
RUN git clone https://github.com/FranckPachot/mattermost.git 
WORKDIR /home/mattermost
# install nvm 
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
RUN . ~/.nvm/nvm.sh ; . ~/.nvm/bash_completion ; nvm install
RUN sed -e '/MM_NO_DOCKER/s/false/true/' -i server/config.mk 
# start mattermost
WORKDIR /home/mattermost/server
# RUN make setup-go-work prepackaged-binaries validate-go-version
RUN make run-server ; make test-data ; true # just try to compile what is necessary
RUN make config-reset
# create accounts without an invitation
RUN sed -e "/EnableOpenServer/s/false/true/" -i config/config.json
# allow local mode
RUN sed -e "/EnableLocalMode/s/false/true/" -i config/config.json
# run the server after updating the config
#CMD sed '/"DataSource":/c "DataSource": "'${DB_URL}'",' -i config/config.json && make run-server && sleep infinity
ENTRYPOINT sed '/"DataSource":/c "DataSource": "'${DB_URL}'",' -i config/config.json && bash



