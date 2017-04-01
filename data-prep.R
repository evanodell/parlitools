

  west_hex_map <- rgdal::readOGR("./data/GB_Hex_Cartogram_Const.shp", "GB_Hex_Cartogram_Const")

  devtools::use_data(west_hex_map)



