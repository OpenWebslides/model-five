# Model Five

Model Five is a Slackbot that manages and deploys the Open Webslides platform. He's also fun outside office hours.

## Installation

Clone the repository, and install all dependencies:

```shell
$ bundle install
```

Install and start the Redis daemon.

## Configuration

Copy the `model_five.env.example` file to `model_five.env` and change the Slack API token.
Copy the `config/model_five.yml.example` file to `config/model_five.yml` and change the variables accordingly.

## Usage

```shell
$ docker build -t openwebslides/model_five:latest .
$ docker-compose up
```

## Contributing

1. Fork it ( https://github.com/OpenWebslides/model_five/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
