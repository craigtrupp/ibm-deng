# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Timedelta for scheduler
from datetime import timedelta
# This makes scheduling easy
from airflow.utils.dates import days_ago
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator

# Set Args
dag_default_args = {
    'owner': 'Craig',
    'start_date': days_ago(0),
    'email': ['dummy_address@somemail.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}
# Define DAG
dag = DAG(
    'ETL_toll_data',
    default_args=dag_default_args,
    description='Apache Airflow Final Assignment',
    schedule_interval=timedelta(days=1),
)
# Tasks
unzip_data = BashOperator(
    task_id='unzip_data',
    bash_command='tar -zxf /home/project/airflow/dags/finalassignment/tolldata.tgz',
    dag=dag,
)
extract_data_from_csv = BashOperator(
    task_id='extract_data_from_csv',
    bash_command='cut -d"," f1-4 /home/project/airflow/dags/finalassignment/vehicle-data.csv > /home/project/airflow/dags/finalassignment/csv_data.csv',
    dag=dag,
)
# You don't need to specify the -d option because tab is the default delimiter. From man cut:
extract_data_from_tsv = BashOperator(
    task_id='extract_data_from_tsv',
    bash_command='cut -f5-7 /home/project/airflow/dags/finalassignment/tollplaza-data.tsv > /home/project/airflow/dags/finalassignment/tsv_data.csv',
    dag=dag,
)
# https://linuxhint.com/bash_tr_command/ - this was helpful and we can manipulate a string to then use a space delimiter to get the last two columns
extract_data_from_fixed_width = BashOperator(
    task_id='extract_data_from_fixed_width',
    bash_command='cat /home/project/airflow/dags/finalassignment/payment-data.txt | tr -s "[:space:]" | cut -d ' ' -f11,12 > /home/project/airflow/dags/finalassignment/fixed_width_data.csv',
    dag=dag,
)
# consolidate data, set file paths
csv_file = "/home/project/airflow/dags/finalassignment/csv_data.csv"
tsv_file = "/home/project/airflow/dags/finalassignment/tsv_data.csv"
fwidth_file = "/home/project/airflow/dags/finalassignment/fixed_width_data.csv"
extract_file = "/home/project/airflow/dags/finalassignment/extracted_data.csv"
consolidate_data = BashOperator(
    task_id='consolidate_data',
    bash_command=f'paste {csv_file} {tsv_file} {fwidth_file} > {extract_file}',
    dag=dag,
)
# transform & load
transform_data = BashOperator(
    task_id='transform_data',
    bash_command='tr "[a-z]" "[A-Z" < {extract_file} > /home/project/airflow/dags/finalassignment/transformed_data.csv',
    dag=dag,
)
# task pipeline
unzip_data >> extract_data_from_csv >> extract_data_from_tsv >> extract_data_from_fixed_width >> consolidate_data >> transform_data