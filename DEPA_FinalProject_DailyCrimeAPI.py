#!/usr/bin/env python
# coding: utf-8

# # Safety on Public Transportation in Chicago
# 
# ## Script for Daily API Call of Crime Data
# 
# ### Authors: Jainam Mehta, Julian Kleindiek, Lola Johnston, Peter Eusebio
# ### Date: 12/06/2019

# ## Step 1: Daily refresh of crime data

# In[1]:


# installed these libraries on the virtual machine on GCP
# !pip install pandas
# !pip install numpy
# !pip install sodapy
# !pip install sqlalchemy
# !pip install pymysql


# In[35]:


# import libraries
from sodapy import Socrata # for API calls
import sqlalchemy as db # for SQL
import pymysql # for SQL
import pandas as pd # for data cleaning
import datetime # for data cleaning
import numpy as np #for grid generation math
import math #for grid generation math.  standard module, shouldn't need installation.


# ## Step 2: Connect to crime table on GCP

# In[3]:


# create connection to CloudSQL
engine = db.create_engine('mysql+pymysql://root:patronus@146.148.80.202/mydb')
connection = engine.connect()
metadata = db.MetaData()


# In[60]:


## WARNING: only run this when neccessary as this will be charged for
# pull crime data from CloudSQL

# define table
crime_GCP = db.Table('crime', metadata, autoload=True, autoload_with=engine)

# query the table
query = db.select([crime_GCP])

# store query as data frame
crime_GCP = pd.read_sql(query, connection)
crime_GCP.head()


# ## Step 2: Daily refresh of crime data

# In[107]:


# pull most recent date from crime table
latest_date_dirty = crime_GCP.datetime.max()

# convert latest date as string
latest_date = latest_date_dirty.strftime('%Y-%m-%dT%H:%M:%S.%f')
latest_date


# In[108]:


# prepare API statement: filter for dates that are more recent than the max date in the table
updated_statement = "date > '" + latest_date + "' AND location_description = 'CTA PLATFORM' OR date > '" + latest_date + "' AND location_description = 'CTA BUS' OR date > '" + latest_date + "' AND location_description = 'CTA TRAIN' OR date > '" + latest_date + "' AND location_description = 'CTA BUS STOP' OR date > '" + latest_date + "' AND location_description = 'CTA GARAGE / OTHER PROPERTY'"
updated_statement


# In[109]:


# Pull all crime data after the latest_date and for crimes with a location description related to CTA
client = Socrata("data.cityofchicago.org",
                  "QtMhXqaTTglPlVS3AC6PEQQxD", username = "juli.kleindiek@gmail.com", password = "DEPA_2019")

# WARNING: This query is not limited
results = client.get("ijzp-q8t2", 
                     where = updated_statement)


# In[110]:


# Convert results to pandas DataFrame
crime_new_dirty = pd.DataFrame.from_records(results)


# ## Step 3: Clean the fresh crime data

# In[111]:


# bring dataframe into proper format
crime_new = crime_new_dirty[['id', 
        'case_number', 
        'date', 
        'block', 
        'iucr', 
        'primary_type', 
        'description', 
        'location_description',
        'arrest',
        'domestic',
        'beat',
        'district',
        'ward',
        'community_area',
        'fbi_code',
        'x_coordinate',
        'y_coordinate',
        'year',
        'updated_on',
        'latitude',
        'longitude']]


# In[112]:


# rename column names using camelCase
crime_new.columns = ['crimeID', 'caseNumber', 'datetime', 'block', 'iucr', 'primaryType', 'description', 'locationDescription', 'arrest', 'domestic',
                'beat', 'district', 'ward', 'communityArea', 'fbiCode', 'xCoordinate', 'yCoordinate', 'year', 'updatedOn', 'latitude', 'longitude']


# In[113]:


# define proper data types for each column using a dictionary
convertDict = {'crimeID': int, 
               'caseNumber': str,
               'datetime': object,
               'block': str,
               'iucr': str,
               'primaryType': str,
               'description': str,
               'locationDescription': str,
               'arrest': bool,
               'domestic': bool,
               'beat': int,
               'district': int,
               'ward': float,
               'communityArea': float,
               'fbiCode': str,
               'xCoordinate': float,
               'yCoordinate': float,
               'year': object,
               'updatedOn': object,
               'latitude': float,
               'longitude': float,
               }


# In[114]:


# convert the datatypes for all columns using covertDict
crime_new = crime_new.astype(convertDict) 

# convert the 'Date' column to datetime format 
from datetime import datetime
from datetime import date

crime_new['datetime']= pd.to_datetime(crime_new['datetime'])
crime_new['updatedOn']= pd.to_datetime(crime_new['updatedOn']) 


# In[115]:


# set index of crime dataframe to 'crimeID'
crime_new = crime_new.set_index('crimeID')


# In[116]:


#adding date column from datetime
crime_new['date'] = crime_new['datetime'].dt.date
crime_new['date'] = pd.to_datetime(crime_new['date']) 


# In[ ]:


# Add time column from datetime
crime_new['time'] = crime_new['datetime'].dt.time


# In[117]:


#mask lat and long outside reasonable bounds
crime_new[['latitude','longitude']] = crime_new[['latitude','longitude']].mask((crime_new['latitude'] < 40) | (crime_new['latitude'] > 43))
crime_new[['latitude','longitude']] = crime_new[['latitude','longitude']].mask((crime_new['longitude'] < -89) | (crime_new['longitude'] > -86))

# creating a bool series True for NaN values  
boolSeries = pd.notnull(crime_new['latitude']) & pd.notnull(crime_new['longitude'])  
    
# filtering data  
# displaying data only with lat and long = Not NaN  
crime_new = crime_new[boolSeries]


# ## Step 5: Assign GridID to crime data

# In[118]:


#static grid definition to be shared between data prep and daily api notebooks

x = np.array([-87.94438768, -87.92551976, -87.90665183, -87.88778391, -87.86891599,
 -87.85004806, -87.83118014, -87.81231221, -87.79344429, -87.77457636,
 -87.75570844, -87.73684051, -87.71797259, -87.69910466, -87.68023674,
 -87.66136882, -87.64250089, -87.62363297, -87.60476504, -87.58589712,
 -87.56702919, -87.54816127, -87.52929334, -87.51042542, -87.49155749,
 -87.47268957])

y = np.array([41.62419999, 41.63869275, 41.6531855,  41.66767826, 41.68217101, 41.69666376,
 41.71115652, 41.72564927, 41.74014202, 41.75463478, 41.76912753, 41.78362028,
 41.79811304, 41.81260579, 41.82709854, 41.8415913,  41.85608405, 41.87057681,
 41.88506956, 41.89956231, 41.91405507, 41.92854782, 41.94304057, 41.95753333,
 41.97202608, 41.98651883, 42.00101159, 42.01550434, 42.0299971,  42.04448985,
 42.0589826 ])


# In[119]:


#function that gives gridId corresponding to a lat long pair

def gridsort(lat,long):
    
    xin = np.nan
    yin = np.nan
    
    for i in range(0,len(x)-1):
        if (x[i] <= long) & (long < x[i+1]):
            xin = float(i)

    for i in range(0,len(y)-1):
        if (y[i] <= lat) & (lat < y[i+1]):
            yin = float(i)
    
    gridId = int((xin + 1) + (len(x)-1)*(yin))
    
    return gridId


# In[120]:


#adding gridId column to crime dataframe by applying the gridsort function
crime_new['gridId'] = np.vectorize(gridsort)(crime_new['latitude'], crime_new['longitude'])
crime_new.head()


# ## Step 6: Append daily updated crime data to the crime database in CloudSQL

# In[121]:


crime_new.info()


# In[122]:


# check that earliest date of new crime data is later than latest date in crime table
crime_GCP.datetime.max() < crime_new.datetime.min()


# In[126]:


# push data into CloudSQL table; change if_exist in case no data exists
crime_new.to_sql('crime', con=engine, if_exists='append', index=False)

