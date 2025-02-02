# ipl-azure-data-engingeering
> This project is to analyze IPL data using various tools and technologies, including Azure Data Factory, Data Lake Gen 2, Synapse Analytics, and Azure Databricks.

# Table of Contents
- [Overview of the Design](#overview-of-the-design)
- [Dataset](#Dataset)
- [Tech Stack](#Tech-Stack)
- [Setting the workspace](#setting-the-workspace)
- [Pipeline Flow](#pipeline-flow)
- [Secrets-Management](#Secrets-Management)
  - [Azure Key Valut-backed scopes](#Azure-backed-secret-scope)
  - [Databricks-backed scopes](https://github.com/nk3099/paris-olympic-azure-data-engingeering/blob/main/README.md#Databricks-backed-secret-scope)
- [Azure Authentication & Authorization](#Azure-Authentication-&-Authorization)
- [Power-BI](#power-bi)
- [Debug Errors](#debug-errors)


# <a name="overview-of-the-design"></a> Overview of the Design
![image](https://github.com/user-attachments/assets/e27e349d-c01b-45c8-aaa8-fbd579c8ac2c)


# <a name="Dataset"></a>Dataset
For this project, we are going to use the [IPL Dataset](https://data.world/raghu543/ipl-data-till-2017). Also, have added the dataset in [data](https://github.com/nk3099/IPL_Data_Analysis_Pyspark/blob/main/data/ipl-data.zip) folder

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

Please refer [here](https://www.databricks.com/glossary/medallion-architecture) to know more about medallion-architecture.

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
- We are following Medallion-Architecture for our storage: \
  @ipl3099datalakegen2 (ADLS gen2) : Containers > 
```
1.bronze
2.silver
3.gold
```
![ipl_adls2](https://github.com/user-attachments/assets/fea685c9-1272-40c5-8b9c-995f02de573d)

### DataBricks:
Please find the notebooks for: 
1. [ipl-3099_storage_mount_to_dfbs](https://github.com/nk3099/IPL_Data_Analysis_Pyspark/blob/main/databricks/ipl-3099_storage_mount_to_dbfs.ipynb) 
2. [ipl-3099_bronze-to_silver](https://github.com/nk3099/IPL_Data_Analysis_Pyspark/blob/main/databricks/ipl-3099_bronze_to_silver.ipynb) 
3. [ipl-3099_silver-to_gold](https://github.com/nk3099/IPL_Data_Analysis_Pyspark/blob/main/databricks/ipl-3099_bronze_to_silver.ipynb)

![databricks](https://github.com/user-attachments/assets/e1d6bac4-3a43-4657-9ba5-6d962a31ff59)

### File Structure:

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


### On-Premise SQL:
Please find the files as below:
1. [createlogin.sql](https://github.com/nk3099/IPL_Data_Analysis_Pyspark/blob/main/sql_files/createlogin.sql)
2. [get_tableschema.sql](https://github.com/nk3099/IPL_Data_Analysis_Pyspark/blob/main/sql_files/get_tableschema.sql)
   
 ![sql_ssms](https://github.com/user-attachments/assets/36f87b68-afde-40b7-b9b8-4fcd9b476427)

### Synapse:
3. [StoredProcedure_CreateSQLServerlessView_ipl_gold_layer_db.sql](https://github.com/nk3099/IPL_Data_Analysis_Pyspark/blob/main/sql_files/StoredProcedure_CreateSQLServerlessView_ipl_gold_layer_db.sql)
   
![synapse_stored_procedure](https://github.com/user-attachments/assets/608f8f64-8839-42e2-9d49-57b5db6c69f5)

# <a name="pipeline-flow"></a> Pipeline Flow

#### Single Table Copy Acitivty:
![ADF_pipeline1_success](https://github.com/user-attachments/assets/afa80bba-7f56-4adf-9728-bd82d735d7cf)

#### Multiple Tables Copy Activity and Pipeline Sequence:
![ADFP_pipelineRun2](https://github.com/user-attachments/assets/f8982299-1036-4d78-9229-7d13b77905cb)

# <a name="Secrets-Management"></a> Secrets Management
```
Managing secrets begins with creating a secret scope. A secret scope is collection of secrets identified by a name.
A workspace is limited to a maximum of 1000 secrets scopes.

There are two types of secret scopes:
- Azure Key Vault-backed scopes
- Databricks-backed scopes
```
## <a name="Azure-backed-secret-scope"></a> Azure-backed secret scope
To reference secrets stored in an Azure Key Vault, we need to create a secret scope backed by Azure Key Vault.
![ipl-scopes](https://github.com/user-attachments/assets/b7b650d8-2276-4d1d-b04b-c105e5059524)

### Steps:
1. Go to https://\<databricks-instance>\#secrets/createScope
   ```
   created scope="ipl_project_scope"
   ```
   ![ipl-scope](https://github.com/user-attachments/assets/59087c1f-8119-414f-8027-71fee2c66113)

2. Create secrets inside Azure Key-vault for the "ipl_project_scope"
```
created secret key="iplAccountKeySecret"
```
![key-vault-scope](https://github.com/user-attachments/assets/2cde62e0-6864-4e5d-ae6b-cff2571c3cad)

3.Use the secret scopes in Databricks.
![ipl-databricks-scope](https://github.com/user-attachments/assets/7f25b735-25d2-4e2e-b48f-6e7995c10d76)


# <a name="Azure-Authentication-&-Authorization"></a> Azure Authentication & Authorization
To effectively segregate authentication and authorization in Azure, it's important to understand their distinct roles and how they apply to different storage types like ABFS (Azure Blob File System) and WASBS (Windows Azure Storage Blob Service). 

- Authentication: This verifies the identity of users or services trying to access Azure resources. \
- Authorization: This determines what authenticated users or services are allowed to do (e.g., read, write, delete) with those resources.

## Authentication Methods:

Azure Active Directory (Azure AD):
```
Commonly used for authentication in Azure services, including:
ABFS: Typically used with Azure Data Lake Storage Gen2, Azure AD can authenticate users and applications accessing data.
WASBS: While WASBS primarily relies on account keys or Shared Access Signatures (SAS), Azure AD can also be configured for authentication.
```
Storage Account Keys:
```
Used for both ABFS and WASBS to authenticate to the storage account directly.
Best suited for scenarios where you need programmatic access without using Azure AD.
```
Shared Access Signatures (SAS):
```
Provide a way to grant limited access to storage resources without exposing account keys.
Can be used with both ABFS and WASBS for temporary, scoped permissions.
```
Managed Identities:
```
Automatically manage credentials for Azure services, allowing applications to authenticate to Azure services without needing to store credentials.
Works well with both ABFS and WASBS.
```
## Authorization Methods:

Role-Based Access Control (RBAC):
```
Azure RBAC can be used to assign roles to users, groups, or applications, allowing fine-grained control over what actions they can perform on storage resources.
Applicable for both ABFS and WASBS.
```
Access Control Lists (ACLs):
```
For ABFS (Azure Data Lake Storage), you can define ACLs at both the directory and file levels to specify permissions (read, write, execute).
WASBS also supports Blob-level ACLs but is less granular compared to ABFS.
```
Container-level Permissions:
```
For WASBS, you can set permissions at the container level, which determines access to all blobs within that container.
```

# <a name="power-bi"></a> Power BI
![powerbi](https://github.com/user-attachments/assets/5021b632-c09f-4de4-a2a2-e87a786e930e)


# <a name="debug-errors"></a> Debug Errors
please find [debug-errors](https://github.com/nk3099/IPL_Data_Analysis_Pyspark/blob/main/debug/debug.txt) file which contains the errors encountered (few screenshots attached below) and their solutions :)

![ADF_pipeline1_failed](https://github.com/user-attachments/assets/d42c78fa-af74-49dd-95e8-9d39de49cdb5)

![ADF_pipelineRun1](https://github.com/user-attachments/assets/0b2d1346-f0ce-4438-ac7d-dee3242a9fd8)


