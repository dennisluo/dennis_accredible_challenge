Hey team!
Thank you for the challenge and really had fun working on this.
In this code repository you will find all the code needed to create the output used in my looker studio visualisations.

The code that needs to be reviewed is in https://github.com/dennisluo/dennis_accredible_challenge/tree/master/accredible/models. 

This contains the documentation, tests and models used to build the final output.
The rest of the folders are just dbt setup files.

Structure of models:

- The staging folder has a 1:1 link to the source csv files provided and cleans the data.
- The marts folder then gets the relevant data we need in the form of output tables which are ingested back into bigquery so they can be referenced in looker studio.
- The final outputs are 2 tables - dim_deals.sql and fct_deal_stages.sql.
- The dim_deals table stores information on the deal itself whereas the fct_deal_stages contains the business process of a deal moving between stages in the pipeline.
- The entity relationship diagram (ERD) is shown below:

![image](https://github.com/dennisluo/dennis_accredible_challenge/assets/11378773/37211f9e-60cc-4988-8f95-7046a7d1a6f1)

Since the code repository is coded to use my local bigquery connections and setup I have taken the liberty to store the intended output tables as csvs in
https://github.com/dennisluo/dennis_accredible_challenge/tree/master/output. 

Here you can see what the output should look like and what's being used in looker studio.

Both output tables are then joined together in looker studio to provide the 'explore' we need to create our charts.
In looker studio you can filter all the charts by close date and deal source type dimensions.

The looker report with the charts can be found here:

https://lookerstudio.google.com/reporting/bfc71f73-9036-49f6-95f3-72f390bf35ab/page/jvOsD/edit
