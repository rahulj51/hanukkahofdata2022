set -e
echo "Running models but first checking if ingestion is completed."
dbt --version
python wait_for_ingestion.py
echo "Ingestion completed. Proceeding ahead with models."
#echo "Installing dependencies"
#dbt deps
echo "Running models"
dbt run --profiles-dir .
echo "Generating docs"
dbt docs generate --profiles-dir .
echo "Serving docs on localhost:8080"
dbt docs serve

