# IPL_Data_Analysis_Pyspark

## Table of Contents:
- [Overview of the Design](overview-of-the-design)
   - [problem Statement](problem-statement)

## Overview of the Design

In this blog post, we will understand how to perform simple operations on top of a relational database to get valuable Insights using Apache Spark.

## Problem Statement:
```

We have five data tables which are of type CSV. We are performing basic joins in those tables and Creating a Demoralized data frame so that we could perform some processing and Analytics on top of our Data.

```

```sql
SELECT * FROM
ABC;

```

## Dataset:
For this project, we are going to use the [IPL Dataset](https://data.world/raghu543/ipl-data-till-2017). These Datasets consist of three tables customer, orders, and order_items.

## Tech Stack / Skill used:
- Spark
- SQL

## Setting the workspace:
We will use Databricks Community Edition which is free of cost to perform the Spark operations if you prefer to use spark locally or in the Hadoop cluster it’s fine.
![ADF_pipeline1_adlsgen2_parquetdata](https://github.com/user-attachments/assets/8a9b3d70-9d01-4567-b685-08d3b8c54807)

Refer: https://www.databricks.com/product/faq/community-edition
![ADF_pipeline1_failed](https://github.com/user-attachments/assets/d42c78fa-af74-49dd-95e8-9d39de49cdb5)

After setting up the workspace create a cluster and Open a workbook. You are all set to go.
![ADF_pipeline1_success](https://github.com/user-attachments/assets/afa80bba-7f56-4adf-9728-bd82d735d7cf)

Project:

![ADF_pipelineRun1](https://github.com/user-attachments/assets/0b2d1346-f0ce-4438-ac7d-dee3242a9fd8)


![ADFP_pipelineRun2](https://github.com/user-attachments/assets/f8982299-1036-4d78-9229-7d13b77905cb)



![ADFP_pipelineRun2](https://github.com/user-attachments/assets/f954727b-e019-43d2-9404-53f0f3af0dc4)


![ipl-scopes](https://github.com/user-attachments/assets/b7b650d8-2276-4d1d-b04b-c105e5059524)

Now it's time to add our data to the Databricks.
