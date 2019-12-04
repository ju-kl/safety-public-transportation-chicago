# Safety on Public Transportation in Chicago

### Authors: Jainam Mehta, Julian Kleindiek, Lola Johnston, Peter Eusebio
### Date: 12/06/2019

GitHub repository for the final project of the Data Engineering Platforms course at the University of Chicago.

Crime on public transportation and in its surroundings is severe in Chicago, posing a threat to consumers and a challenge to law enforcement authorities. Many of the UChicago students are frequently using public transportation and hence affected by this issue. The objective of this project is to discover patterns in the occurrence of crime on and around public transportation. The insights derived from this analysis should be used to give consumers guidance on the risk related to taking the route that they are anticipating to take.

This project and repository comprises the following scripts:

### DataPreparation
This script deals with the entire data preparation for this project. Data on crime statistics, public transportation, weather and public holidays are pulled from different sources and subsequently cleaned and prepared for analysis. As a final step, the data is pushed into a Google Cloud Platform (GCP) CloudSQL instance.

### ddlCloudSQL
This script established the required database schema on the GCP CloudSQL instance. 

### SQLquery
The SQL queries contained in this script pull specific data from the GCP CLoudSQL instance to veryfiy data is properly loaded.

### DailyCrimeAPI (.ipynb, .py)
The crime statistics are made available through an API by the City of Chicago. The data is published daily and for us to have the most up-to-date data for analysis, we also refresh the data on GCP on a daily basis. This script pulls the newly published data, cleans and prepares it, and appends it to the crime data table on GCP CloudSQL. The script is stored as a jupyter notebook and as a python file for execution purposes.

### vmScript
To run the daily execution of the DailyCrimeAPI script, a dedicated Bucket and Compute Engine was setup on GCP. This script performs the required installations on the virtual machine, pulls the .py script from the Bucket and schedules a daily execution of the script at 8:00 AM CT.

### DataAnalysis
This script includes all analyses performed on the final dataset.

### Dashboard
This dashboard presents the visualization created based ont he final dataset.