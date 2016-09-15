# Welcome to Aphrodite 

Aphrodite is meant to be the simplest way for anyone to configure and preview
Bootstrap. We do this by allowing the users to customize the sass variables
and source directly and then handling all the setup typically associated with
editing a Css Preprocessor. 

This allows the user to either just edit and go or in the future will allow
advanced manipulation of the bootstrap source to create their stylesheets.

Aphrodite provides a utility to preview stylesheets directly on our users sites
without having to actually install it there. This means they can see the exact
result of what the stylesheet will look like before any of their customers can
see it.

## Getting Started

1. Clone the repo

2. Copy the local secrets file
      $ cp config/secrets.local.yml.example config/secrets.local.yml

3. Install libsass

4. Run Rails
      $ rails s

5. Run a worker
      $ bundle exec rake:resque:work QUEUE=*


## Deploying

1. Make a commit

2. Push to master

3. Codeship will test and deploy if the build passes
