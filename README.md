# hanukkahofdata2022
Hanukkah of Data 2022 Solutions
Solutions for https://hanukkah.bluebird.sh/5783/

Solutions are implemented as dbt models.
App is fully self-contained. If you run it via docker, it sets up a Postgres instance,
loads the raw data and then creates subsequent models. `dbt docs` are also generated
and locally hosted.

#### Docker
The project is dockerized. 
  - Run `docker compse build` to build the images. This will take a while
  - Run `docker compuse up` to create the database and run the models.
  - Connect a sql client to Postgres on localhost:5432 to query the data
  - Open `http://localhost:8080` in a web browser to view the dbt docs and lineage


