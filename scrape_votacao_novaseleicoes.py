# -*- coding: utf-8 -*-

# importing modules
#scrape
import requests
import csv
from bs4 import BeautifulSoup
import unicodedata
#time
from datetime import datetime, timedelta
from pytz import timezone

import time

def csv_writer(data, path):
    """
    Write data to aCSV file path
    """
    with open(path, "a") as csv_file:
        writer = csv.writer(csv_file, delimiter=',')
        writer.writerow(data)


while True:
	
	try:
				# http response
		response    =  requests.get('https://www12.senado.leg.br/ecidadania/visualizacaomateria?id=125574')

		soup        = BeautifulSoup(response.content, 'html.parser', from_encoding="iso-8859-1")


		votos = soup.find_all(class_='bloco-result-votos')[0]
		#print votos.prettify()

		#votos = votos[1]
		br = timezone('Brazil/East')
		sa_time = datetime.now(br)
		datahora = sa_time.strftime('%Y-%m-%d %H:%M:%S')
		favor = votos.contents[1].contents[0].replace(".","")
		contra = votos.contents[3].contents[0].replace(".","")


		row = [datahora, favor, contra]
		#print row
		print row


		#fd = open('diretas_data.csv','a',newline='')
		#fd.write(",".join([datahora, favor, contra]))
		#fd.close()

		csv_writer(row, 'diretas_data.csv')

		time.sleep(30)

	except Exception, e:
		time.sleep(30)
	# Python 3.x version
	#import csv
	 


	#writer = csv.writer(open("diretas_data.csv", "ab"), delimiter=',')
	#writer.writerow(row)


