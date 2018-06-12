-- ¿Vale la pena calcular el geohash y asignarle el srid o podemos consultar la tabla donde ya está disponible?
-- TODO: Pasar el año del siose como parámetro
-- TODO: Replace geohashes (text) by a limited character varying

/*
usage: SELECT * FROM split_poly_geo('ezp6r')
*/
CREATE FUNCTION split_poly_geo(geohash text)
RETURNS SETOF s2005.t_poli_geo_castellon AS 
$$ 
SELECT id_polygon,st_transform(st_setsrid(geom,4258),4326),codblq
FROM s2005.t_poli_geo_castellon AS pol
WHERE st_intersects(st_transform(st_setsrid(pol.geom,4258),4326),
					st_setsrid(st_geomfromgeohash($1),4326));
$$
LANGUAGE SQL;

/*
usage: SELECT * FROM split_valores('ezp6r')
*/
CREATE FUNCTION split_valores(geohash text)
RETURNS SETOF s2005.t_valores_castellon AS 
$$ 
SELECT DISTINCT val.* 
FROM split_poly_geo($1) AS pol
LEFT JOIN s2005.t_valores_castellon val USING (id_polygon)
ORDER BY id_polygon, inter_id;
$$
LANGUAGE SQL;

/*
Lookup tables
*/
--SELECT * from s2005.tc_siose_atributos;
--SELECT * from s2005.tc_siose_coberturas;
