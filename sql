
#------------- SQL Code used to define sessions and active days ---------------
SELECT 
   char
  ,_level
  ,_zone
  ,_guild
  ,_timestamp
  ,diff
  ,CASE WHEN diff = 0 then 1 else 0 end as session
  ,day_active
FROM(
    SELECT 
        char
      ,_level
      ,_zone
      ,_guild
      ,_timestamp
      ,COALESCE(CASE WHEN TIMESTAMP_DIFF(_timestamp,next_timestamp,MINUTE) <= 30 THEN TIMESTAMP_DIFF(_timestamp,next_timestamp,MINUTE) ELSE NULL END,0) as diff
      ,CASE WHEN DATE(_timestamp) = DATE(next_timestamp) THEN 0 ELSE 1 END as day_active
    FROM(
        SELECT 
            char
          ,_level
          ,_zone
          ,_guild
          ,_timestamp
          ,LAG(_timestamp) OVER (PARTITION BY char ORDER BY _timestamp) AS next_timestamp
        FROM s
        )ss
    )sss
ORDER BY char,_timestamp

#------------- Python Code used to clean the timestamp format and break up the master CSV ---------------

import csv
from datetime import datetime
ipath = r'/Users/Looker/Documents/pyscripts/wow_infile.csv'
m1path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m1.csv'
m2path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m2.csv'
m3path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m3.csv'
m4path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m4.csv'
m5path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m5.csv'
m6path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m6.csv'
m7path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m7.csv'
m8path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m8.csv'
m9path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m9.csv'
m10path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m10.csv'
m11path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m11.csv'
m12path = r'/Users/Looker/Documents/pyscripts/wow_thesis/wow_m12.csv'

with open(ipath,'r') as infile, open(m1path, "w") as outfile1, open(m2path, "w") as outfile2, open(m3path, "w") as outfile3, open(m4path, "w") as outfile4, open(m5path, "w") as outfile5, open(m6path, "w") as outfile6, open(m7path, "w") as outfile7, open(m8path, "w") as outfile8, open(m9path, "w") as outfile9, open(m10path, "w") as outfile10, open(m11path, "w") as outfile11, open(m12path, "w") as outfile12:

    reader = csv.reader(infile)

    writer1 = csv.writer(outfile1, delimiter=',')
    writer2 = csv.writer(outfile2, delimiter=',')
    writer3 = csv.writer(outfile3, delimiter=',')
    writer4 = csv.writer(outfile4, delimiter=',')
    writer5 = csv.writer(outfile5, delimiter=',')
    writer6 = csv.writer(outfile6, delimiter=',')
    writer7 = csv.writer(outfile7, delimiter=',')
    writer8 = csv.writer(outfile8, delimiter=',')
    writer9 = csv.writer(outfile9, delimiter=',')
    writer10 = csv.writer(outfile10, delimiter=',')
    writer11 = csv.writer(outfile11, delimiter=',')
    writer12 = csv.writer(outfile12, delimiter=',')
    
    head = next(reader)
    
    writer1.writerow(head)
    writer2.writerow(head)
    writer3.writerow(head)
    writer4.writerow(head)
    writer5.writerow(head)
    writer6.writerow(head)
    writer7.writerow(head)
    writer8.writerow(head)
    writer9.writerow(head)
    writer10.writerow(head)
    writer11.writerow(head)
    writer12.writerow(head)

    for row in reader:
        d = row[6]
        dt = datetime.strptime(d,'%m/%d/%y %H:%M:%S')
        row[6] = dt
        month = dt.month
        if month in [1]:            
            print("jan")
            writer1.writerow(row)
        elif month in [2]:
            print("feb")
            writer2.writerow(row)
        elif month in [3]:
            print("mar")
            writer3.writerow(row)
        elif month in [4]:
            print("apr")
            writer4.writerow(row)
        elif month in [5]:
            print("may")
            writer5.writerow(row)
        elif month in [6]:
            print("jun")
            writer6.writerow(row)
        elif month in [7]:
            print("july")
            writer7.writerow(row)
        elif month in [8]:
            print("aug")
            writer8.writerow(row)
        elif month in [9]:
            print("sep")
            writer9.writerow(row)
        elif month in [10]:
            print("oct")
            writer10.writerow(row)
        elif month in [11]:
            print("nov")
            writer11.writerow(row)
        elif month in [12]:
            print("dec")
            writer12.writerow(row)
        else:
            print("fin")
            break
            
		
