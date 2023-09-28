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
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}
# Define DAG
dag = DAG(
    dag_id='test_extract',
    default_args=dag_default_args,
    description='Apache Airflow Final Assignment',
    schedule_interval=timedelta(days=1),
)
# Tasks
# Unzip tgz file which we placed one child level below the dag script we submitted (preface file locations with single ./)
fp = '/home/project/airflow/dags/finalassignment'
unzip_data = BashOperator(
    task_id='unzip_data',
    bash_command=f'tar -zxvf {fp}/tolldata.tgz -C {fp}',
    dag=dag,
)
sample_write = BashOperator(
    task_id='write_test',
    bash_command=f'echo "Do we have something cooking" > {fp}/sample_echo.txt',
    dag=dag,
)
file_destination = BashOperator(
    task_id='directory_path',
    bash_command=f'pwd > {fp}/directory_location.txt',
    dag=dag,
)
file_destination_contents = BashOperator(
    task_id='directory_contents',
    bash_command=f'ls -l {fp} > {fp}/fpath_file_contents.txt',
    dag=dag,
)
extract_data_from_csv = BashOperator(
    task_id='extract_data_from_csv',
    bash_command=f'cut -d "," -f1-4 {fp}/vehicle-data.csv  > csv_data.csv',
    dag=dag,
)
unzip_data >> sample_write >> file_destination >> file_destination_contents >> extract_data_from_csv