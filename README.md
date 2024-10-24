# IPL_Data_Analysis_Pyspark

# Table of Contents
- [Overview of the Design](#overview-of-the-design)
- [Dataset](#Dataset)
- [Tech Stack](#Tech-Stack)
- [Setting the workspace](#setting-the-workspace)
- [Pipeline Flow](#pipeline-flow)
- [Azure-backed secret scope](#Azure-backed-secret-scope)
- [Debug Errors](#debug-errors)


# <a name="overview-of-the-design"></a> Overview of the Design
![image](https://github.com/user-attachments/assets/e27e349d-c01b-45c8-aaa8-fbd579c8ac2c)


# <a name="Dataset"></a>Dataset
For this project, we are going to use the [IPL Dataset](https://data.world/raghu543/ipl-data-till-2017). These Datasets consist of three tables customer, orders, and order_items.

# <a name="Tech-Stack"></a>Tech Stack
- PySpark
- SQL
- Azure
- Databricks

# <a name="setting-the-workspace"></a> Setting the workspace
![workspace-settings](https://github.com/user-attachments/assets/3e1b1064-4b21-49eb-9f40-15f527a8ed68)

#### ADLS Gen2 (Azure DataLake Storage Gen2):
![ADF_pipeline1_adlsgen2_parquetdata](https://github.com/user-attachments/assets/8a9b3d70-9d01-4567-b685-08d3b8c54807)


# <a name="pipeline-flow"></a> Pipeline Flow

#### Single Table Copy Acitivty:
![ADF_pipeline1_success](https://github.com/user-attachments/assets/afa80bba-7f56-4adf-9728-bd82d735d7cf)

#### Multiple Tables Copy Activity and Pipeline Sequence:
![ADFP_pipelineRun2](https://github.com/user-attachments/assets/f8982299-1036-4d78-9229-7d13b77905cb)


# <a name="Azure-backed-secret-scope"></a> Azure-backed secret scope
A Databricks-backed secret scope is stored in (backed by) an encrypted database owned and managed by Azure Databricks.

![ipl-scopes](https://github.com/user-attachments/assets/b7b650d8-2276-4d1d-b04b-c105e5059524)

![databricks-scope](https://github.com/user-attachments/assets/339d0767-54b9-4b0f-a2fb-da3e87aec26e)


## Steps:

1.Install Databricks CLI and configure with your workspace. \
```
1.pip install databricks-cli
2.databricsk configure --help
3.databricks configure --token
4.Go to C:\Users\.databrickscg (databricks configuration file) and make sure host_url and token is pasted correctly.
```

![configure-databricks-cli](https://github.com/user-attachments/assets/cbacaebb-6e2b-4f19-8365-79c98289193a)


2.Creating azure-backed secret scope commands:
```
1.databricks secrets create-scope --scope <scope-name> --initial-manage-principal users
2.databricks secret put --scope <scope-name> --key <key-name>
3.databricks secrets list --scope <scope-name>
4.databricks secrets delete-scope --scope <scope-name>
```
![scopes](https://github.com/user-attachments/assets/03580fcb-e38c-4fe4-8ef0-861595a1f8da)


# <a name="debug-errors"></a> Debug Errors


![ADF_pipeline1_failed](https://github.com/user-attachments/assets/d42c78fa-af74-49dd-95e8-9d39de49cdb5)

![ADF_pipelineRun1](https://github.com/user-attachments/assets/0b2d1346-f0ce-4438-ac7d-dee3242a9fd8)


