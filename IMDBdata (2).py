import re
import requests
from bs4 import BeautifulSoup

year = "2016"
data = [];
url1= "http://www.imdb.com/search/title?sort=boxoffice_gross_us&title_type=feature&year=" + year + "," + year
# url2= "http://www.imdb.com/search/title?sort=boxoffice_gross_us&title_type=feature&year=" + year + "," + year + "&page=2&ref_=adv_nxt"
html = requests.get(url1).text

soup = BeautifulSoup(html, "html.parser")
all_links_title = soup.find_all("a")
all_links_span = soup.find_all("span")

for link in all_links_title:
        if "title" in link.get("href") and "_tt" in link.get("href"):
                print(link.text)
for link in all_links_span:
        if "nv" == link.get("name") and "$" in link.text:
                rawGross = link.text;
                numGross= rawGross[1:-1];
                print(numGross)
#for link in all_links_span:
#    if "genre" == link.get("class"):
#        print(link.text)

# movite title, genre, year, gross