Using the twitter API during New Years Eve to study tweet location, language and sentiment analysis.

——————
Saving geographical positions and language of tweets using jq (https://stedolan.github.io/jq/) to parse the data:

echo '{"type":"FeatureCollection","features":'"$(cat input.json | jq 'select(.geo)| {type: "Feature", geometry:{type:"Point", coordinates:[.geo.coordinates[1],.geo.coordinates[0]]},properties:{tweet_lang:.lang,handle:.actor.displayName}}' | jq -s .)"'}' > output.json

input.json is the file we want to parse and output.json is the parsed output file.

In this case we have stored the coordinates and the language for each tweet. The result is a GeoJSON type of file.

Create the world maps files by transforming a shape file into a GeoJSON file using ogr2ogr package inside GDAL. Afterwards, we combine the needed files to create the final topoJSON. The shape files can be downloaded in: 

land: http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/physical/ne_110m_land.zip
country: http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip
map_subunits: http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_map_subunits.zip
populated_places: http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places.zip
——————————————————
## Folder twitter_World_US - creating a world map

#cd ne_110m_land/
ogr2ogr -f GeoJSON land.json ne_110m_land.shp 

#cd ne_110m_admin_0_countries/
ogr2ogr -f GeoJSON countries.json ne_110m_admin_0_countries.shp  

# In twitter_World_US folder
topojson -o world.json  -- ne_110m_land/land.json ne_110m_admin_0_countries/countries.json

## in the folder twitter_UK - creating the UK map

# cd ne_110m_populated_places/
ogr2ogr \
  -f GeoJSON \
  -where "ADM0_A3 IN ('GBR', 'IRL')" \
  subunits.json \
  ne_10m_admin_0_map_subunits.shp

# cd ne_10m_populated_places/
ogr2ogr \
  -f GeoJSON \
  -where "ISO_A2 = 'GB' AND SCALERANK < 8" \
  places.json \
  ne_10m_populated_places.shp

# In twitter_UK folder
topojson \
  -o uk.json \
  --id-property SU_A3 \
  --properties name=NAME \
  -- \
  subunits.json \
  places.json
———————————

The resulting maps are going to apear in the browser (running in folder): 
- Initiate python http server: python -m SimpleHTTPServer 8080 
- run index.html: http://localhost:8080/index.html


TO DO:
- Add country borders
- Add different colours
- Add different colours to twitter languages
- Add sentiment analysis



References: 
http://support.gnip.com/articles/visualizing-twitter-geo-data.html
http://bost.ocks.org/mike/map/


