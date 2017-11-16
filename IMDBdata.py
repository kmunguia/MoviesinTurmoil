import re
import requests
from bs4 import BeautifulSoup
import csv


year = ""
data = []
url1= ""
url2= ""
#html = ""

#soup = None
all_links_title = ""
all_links_span = ""

movies = []
rev = []

def movieTitle():
    for link in all_links_title:
        if "title" in link.get("href") and "_tt" in link.get("href"):
            movies.append(link.text)
            #list1.append(link.text)
            #print(link.text)
            #print(list1)            

    return(movies)
                
def revenue():
    for link in all_links_span:
        if "nv" == link.get("name") and "$" in link.text:
            rev.append(link.text)
            #print(link.text)
    return(rev)
 
def main():
    years = []
    for i in range(1988,1989):
        #year = i
        year = str(i)
        #year = ""
        data = [];
        url1= "http://www.imdb.com/search/title?sort=boxoffice_gross_us&title_type=feature&year=" + year + "," + year
        #url2= "http://www.imdb.com/search/title?sort=boxoffice_gross_us&title_type=feature&year=" + year + "," + year + "&page=2&ref_=adv_nxt"
        
        html = requests.get(url1).text
        soup = BeautifulSoup(html, "html.parser")
        all_links_title = soup.find_all("a")
        all_links_span = soup.find_all("span") 
        
        list1= movieTitle()
        list2 =revenue()
        unicodestring = ""
        
        utf8string = unicodestring.encode("utf-8")
        asciistring = unicodestring.encode("ascii")
        isostring = unicodestring.encode("ISO-8859-1")    
        
        for link in all_links_title:
            if "title" in link.get("href") and "_tt" in link.get("href"):
                #print(link.text)
                unicodestring = link.text
                #utf8string = unicodestring.encode("utf-8")
                #asciistring = unicodestring.encode("ascii")
                isostring = unicodestring.encode("ISO-8859-1")            
                list1.append(isostring)
        #print(list1)
        for link in all_links_span:
            if "nv" == link.get("name") and "$" in link.text:
                #unicodestring = link.text
                #utf8string = unicodestring.encode("utf-8")
                #asciistring = unicodestring.encode("ascii")
                #isostring = unicodestring.encode("ISO-8859-1")            
                #list1.append(isostring)            
                list2.append(link.text)
        #print(list2) 
    for i in range(0,50):
        years.append(year)
            
            
       
        l = [(years), (list1), (list2)]
        #print(list1)
        #print(list2)
        #print(zip(*l))
        
        with open("capstone2.csv", "a") as f:
            fileWriter = csv.writer(f, delimiter=',',quotechar='|', quoting=csv.QUOTE_MINIMAL)
            for row in zip(*l):
                fileWriter.writerow(row)    
 
           
    
            
main()
    
    