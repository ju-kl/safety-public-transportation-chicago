# Safety on Public Transportation in Chicago

**Authors:** Jainam Mehta, Julian Kleindiek, Lola Johnston, Peter Eusebio

**Date:** 12/06/2019

GitHub repository for our final project of the 'Data Engineering Platforms for Analytics' course at the University of Chicago.
https://github.com/ju-kl/safety_public_transportation_chicago

Crime on public transportation and in its surroundings is severe in Chicago, posing a threat to consumers and a challenge to law enforcement authorities. Many UChicago students frequently use public transportation and hence are affected by this issue. The objective of this project is to discover patterns in the occurrence of crime on and around public transportation. The insights derived from this analysis should be used to give consumers guidance on the risk related to the route that they are anticipating to take.

This project and repository comprises the following:

### Data Ingestion and Preparation  

**DataPreparation.ipynb**  
This script deals with the entire data preparation for this project. Data on crime statistics, public transportation, weather and public holidays are pulled from different sources and subsequently cleaned and prepared for analysis. As a final step, the data is pushed into a Google Cloud Platform (GCP) CloudSQL instance.

**ddlCloudSQL.sql**  
This script creates the required database schema on the GCP CloudSQL instance. 

**EER Diagram (.mwb, .png)**  
This file shows the final EER diagram for our database.

**DailyCrimeAPI (.ipynb, .py)**  
The crime statistics are made available through an API by the City of Chicago. The data is published daily and for us to have the most up-to-date data for analysis, we also refresh the data on GCP on a daily basis. This script pulls the newly published data, cleans and prepares it, and appends it to the crime data table on GCP CloudSQL. The script is stored as a jupyter notebook and as a python file for execution purposes.

**vmScript.txt**  
To run the daily execution of the DailyCrimeAPI script, a dedicated Bucket and Compute Engine was setup on GCP. This script performs the required installations on the virtual machine, pulls the .py script from the Bucket and schedules a daily execution of the script at 8:00 AM CT.

**gridPolygonCreation.ipynb**  
This script creates polygons for each gridId and outputs a .shp for us to visualize the grids in Tableu and perform respective analyses.  


### Data Analysis, Visualization and Insights

**DataAnalysis.ipynb**  
This script includes all analyses performed on the final dataset.

**SQLqueries.sql**  
The SQL queries contained in this script pull specific data from the GCP CLoudSQL instance to veryfiy data is properly loaded. Other queries are also used for exploratory data analysis and generating insights.

**Dashboard.twbx and BusCrimeDemo.twbx**  
The Dashboard presents the visualization created based on the final dataset, while the BusCrimeDemo was used as an in-class demo to present the risk-levels of bus stops and corresponding routes.

**DEPA_G6_Final_Project_v4.pptx**  
This presentation summarizes the entire project and its findings.
