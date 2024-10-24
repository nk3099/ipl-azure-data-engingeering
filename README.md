# IPL_Data_Analysis_Pyspark

# Table of Contents
- [Overview of the Design](#overview-of-the-design)
- [Dataset](#Dataset)
- [Tech Stack](#Tech-Stack)
- [Setting the workspace](#setting-the-workspace)
- [Pipeline Flow](#pipeline-flow)
- [Azure-backed secret scope](#Azure-backed-secret-scope)
- [Power-BI](#power-bi)
- [Debug Errors](#debug-errors)


# <a name="overview-of-the-design"></a> Overview of the Design
![image](https://github.com/user-attachments/assets/e27e349d-c01b-45c8-aaa8-fbd579c8ac2c)


# <a name="Dataset"></a>Dataset
For this project, we are going to use the [IPL Dataset](https://data.world/raghu543/ipl-data-till-2017). Also, have added the dataset in [ipl-data.zip](https://github.com/nk3099/IPL_Data_Analysis_Pyspark/blob/main/ipl-data.zip) folder

These Datasets consists of following tables:
- Ball_by_Ball
- Match
- Player
- Player_Match
- Team


# <a name="Tech-Stack"></a>Tech Stack
- PySpark
- SQL
- Azure
- Databricks

  
# <a name="Medallion-Architecture"></a> Medallion Architecure
A medallion architecture is a data design pattern used to logically organize data in a lakehouse, with the goal of incrementally and progressively improving the structure and quality of data as it flows through each layer of the architecture (from Bronze ⇒ Silver ⇒ Gold layer tables). Medallion architectures are sometimes also referred to as "multi-hop" architectures.

![image](https://github.com/user-attachments/assets/8035ef50-77ad-4205-95d5-ef6c18a09944)
Please refer [here](https://www.databricks.com/glossary/medallion-architecture)

### Bronze layer
```
The Bronze layer serves as the initial landing ground for all data originating from external source systems. Datasets within this layer mirror the structures of the source system tables in their original state, supplemented by extra metadata columns such as load date/time and process ID. The primary emphasis here is on Change Data Capture, enabling historical archiving of the source data, maintaining data lineage, facilitating audit trails, and allowing for reprocessing if necessary without requiring a fresh read from the source system.
```

### Silver layer
```
The next layer of the lakehouse is the Silver layer. Within this layer, data from the Bronze layer undergoes a series of operations to a “just-enough” state (which will be discussed in detail later). This prepares the data in the Silver layer to offer an encompassing “enterprise view” comprising essential business entities, concepts, and transactions.
```

### Gold layer
```
The last layer of the lakehouse is the Gold layer. Data within the Gold layer is typically structured into subject area specific databases, primed for consumption. This layer is dedicated to reporting and employs denormalized, read-optimized data models with minimal joins. It serves as the ultimate stage for applying data transformations and quality rules. Commonly, you will observe the integration of Kimball-style star schema based data marts within the Gold Layer of the lakehouse.
```




# <a name="setting-the-workspace"></a> Setting the workspace
![workspace-settings](https://github.com/user-attachments/assets/3e1b1064-4b21-49eb-9f40-15f527a8ed68)

### ADLS Gen2 (Azure DataLake Storage Gen2):
- We are following [Medallion Architecure](#medallion-architecture) for our storage: \
ipl3099datalakegen2 (ADLS gen2) : Containers > 
```
1.bronze
2.silver
3.gold
```
![ipl_adls2](https://github.com/user-attachments/assets/fea685c9-1272-40c5-8b9c-995f02de573d)

#### File Structure

```
1.Bronze > dbo > [Tables] > {files}.parquet:
- Ball_by_Ball.parquet
- Match.parquet
- Player.parquet
- Player_Match.parquet
- Team.parquet
```
![ipl_adls](https://github.com/user-attachments/assets/62e74677-0bb9-4c81-af9b-a2bafb31984f)

```
Similarly,   
2.Silver > [Tables] > {parquet-part-files}
3.Gold > [Tables] > {parquet-part-files}
```
![gold_parquet](https://github.com/user-attachments/assets/cc448014-5613-49bf-81a6-cab11fe14e85)


#### On-Premise SQL:
Please find the files as below:
1. [createlogin.sql]()
2. [get_tableschema.sql]()
3. [StoredProcedure_CreateSQLServerlessView_ipl_gold_layer_db.sql]()
   
![sql_ssms](https://github.com/user-attachments/assets/36f87b68-afde-40b7-b9b8-4fcd9b476427)


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


# <a name="power-bi"></a> Power BI
![powerbi](https://github.com/user-attachments/assets/5021b632-c09f-4de4-a2a2-e87a786e930e)


# <a name="debug-errors"></a> Debug Errors


![ADF_pipeline1_failed](https://github.com/user-attachments/assets/d42c78fa-af74-49dd-95e8-9d39de49cdb5)

![ADF_pipelineRun1](https://github.com/user-attachments/assets/0b2d1346-f0ce-4438-ac7d-dee3242a9fd8)


