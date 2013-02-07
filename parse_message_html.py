from BeautifulSoup import BeautifulSoup
from datetime import datetime
import csv

with open('messages.html', 'r') as file:
	soup = BeautifulSoup(file.read())

messages = soup.findAll("div", attrs={"class":"message"})
mess_dicts = []
authors = {}

your_name = "Cole Gleason"

for message in messages:
	# get timestamp
	time_published_tag = message.find("abbr", attrs={"class":"time published"})
	if (time_published_tag):
		time_published = time_published_tag['title'][0:-5]
		timestamp = datetime.strptime(time_published, '%Y-%m-%dT%H:%M:%S')
	else:
		print "Could not find timestamp for message!"
		print message
		continue

	# get from
	from_tag = message.find("div", attrs = {"class":"from"}).span
	if from_tag:
		author = from_tag.string
		if author not in authors.keys():
			authors[author] = 1
		else:
			authors[author] += 1
	else:
		print "Could not find author for message!"
		print message
		continue

	if author != your_name and author != "Unknown":
		mess_dicts.append({"author":author, "timestamp":timestamp.strftime("%s")})

sorted_messages = sorted(mess_dicts, key=lambda k: k['timestamp'])


with open('fbmessages.csv', 'wb') as csvfile:
	writer = csv.DictWriter(csvfile, ["timestamp", "author"])
	for m in sorted_messages:
		writer.writerow(m)

with open('fbauthors.csv', 'wb') as csvfile:
	writer = csv.writer(csvfile, ["timestamp", "author"])
	for key in authors.keys():
		writer.writerow([key, authors[key]])




	
