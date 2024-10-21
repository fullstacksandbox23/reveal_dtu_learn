# Purpose

Creating slides via web technology.

We're using [Reveal.js](https://revealjs.com) and deploy them to a web server.

# License

see [license file](LICENSE)

# Contributing

Create an issue in the repo and we'll figure it out.

# Development

To start the development server, go to root directory and execute on command line:

```bash
docker compose up -d
```

The development server is available at [http://localhost:8000](http://localhost:8000)
The slides appearing there, are automatically getting updated, when the code changes.

When done editing slides, stop the development server with

```bash
docker compose down
```
# Tests

Run the unit tests from command line via

```bash
./scripts/run_slides_test.sh
```
