from lxml import html
import requests
text = html.get('https://flightaware.com/live/flight/BEL11Y')
print(text)