FROM ruby:2.7.2-alpine3.11

RUN apk update
RUN apk add build-base postgresql-client postgresql-dev yarn git
RUN apk add tzdata

WORKDIR /home/virtual-dash/

# Install Dependencies for Node and Ruby
ENV BUNDLE_PATH /bundle/vendor/
ENV GEM_PATH /bundle/vendor/
ENV GEM_HOME /bundle/vendor/
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install --jobs=4
COPY package.json yarn.lock ./
RUN yarn install
#RUN npm install -g yarn@1.21.1

# Expose
EXPOSE 3000

# Mount All Code
VOLUME ["/home/virtual-dash"]

# Run the server
ENTRYPOINT ["bundle", "exec"]
