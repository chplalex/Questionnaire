# questionnaire

Simple questionnaire with json-server

## Getting Started

Before launching the App, the json-server should be installed and started.
See here for details:
- [JSON Server](https://github.com/typicode/json-server)

As a default parameters the App sets:
- authority - "localhost"
- port - "3000"

The default values of the parameters are valid for the iOS simulator only. If you want use the Android emulator or a physical device, you should start json-server with explicit the Host IP address as -H parameter (required) and port as -p parameter (optionally), for example:

- json-server -H 10.0.2.2 --watch db.json
- json-server -H 192.168.50.35 -p 7777 --watch db.json

Do not forget set these parameters (authority -H and port -p) in the App settings dialog.

Good luck!