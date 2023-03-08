# Skills-API
API to display skills for a Developer. 

### Pre-requisites
The following packages/tools are required to execute this application:
- helm
- docker
- pipenv

### Configs
Skills should be added to a postgreSQL database. Execute `pipenv run env` or `cp .env.example .env`. Add the postgres server details to the `.env` file

### Run
To start up locally, open a terminal window in the root folder run the following commands:
1. `pipenv run migrate` or `python manage.py migrate`
2. `pipenv run helm`

### Author
James Ockhuis
