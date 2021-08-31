<?php

require '/home/inventure/data/web/inventure.com.ua/cms/actual/global.php';


$app = new Skynar\Application('inventure', '/home/inventure/data/web/inventure.com.ua', '/home/inventure/data/web/inventure.com.ua/www');
$app->init();

$sql = 'SELECT t1.id as id, t1.h1 as h1, UNIX_TIMESTAMP(t1.published) as published, t1.short_text as short_text, t1.attr as attr, GROUP_CONCAT(t2.text SEPARATOR \' \') as text, t1.route_id as route, t1.parent_id as parent, t3.views as views, t3.rating as rating, t1.class as t1_class FROM Page as t1 LEFT JOIN PagePart as t2 ON t2.page_id = t1.id LEFT JOIN Analytics_Page as t3 ON t3.page_id = t1.id WHERE t1.status=1 AND t1.deleted=0 AND t2.type LIKE \'13\' GROUP BY t1.id';
$em = $app->getService('doctrine')->getEntityManager();
$conn = $em->getConnection();
$query = $conn->prepare($sql);
$query->execute();
$head = true;
$outstream = fopen("php://output", 'w');
$p = array (
  0 => 
  array (
    0 => 'multi',
    1 => 'categories',
    2 => 'SELECT post_id, page_id FROM post_page',
    3 => 'uint',
    4 => 'post_id',
  ),
  1 => 
  array (
    0 => 'multi',
    1 => 'rubrics',
    2 => 'SELECT post_id, rubric_id FROM post_rubric',
    3 => 'uint',
    4 => 'post_id',
  ),
  2 => 
  array (
    0 => 'timestamp',
    1 => 'published',
  ),
  3 => 
  array (
    0 => 'json',
    1 => 'attr',
  ),
  4 => 
  array (
    0 => 'uint',
    1 => 'route',
  ),
  5 => 
  array (
    0 => 'uint',
    1 => 'parent',
  ),
  6 => 
  array (
    0 => 'uint',
    1 => 'views',
  ),
  7 => 
  array (
    0 => 'float',
    1 => 'rating',
  ),
  8 => 
  array (
    0 => 'uint',
    1 => 't1_class',
  ),
);
$prequery = [];
foreach($p as $a){
	if(!isset($a[2])){
		continue;
	}
	$prequery[$a[1]]=$conn->prepare($a[2].' WHERE '.$a[4].' = :id');
}
$writer = new XMLWriter();  
$writer->openURI('php://output');  
$writer->startDocument('1.0','UTF-8');
$writer->startElement('sphinx:docset'); 
$writer->writeAttribute('lxmlns:sphinx', 'http://sphinxsearch.com/');
while($row = $query->fetch(PDO::FETCH_ASSOC)){
	foreach($prequery as $n=>$q){
		$q->execute(['id'=>$row['id']]);
		$row[$n] = implode(';',$q->fetchAll(PDO::FETCH_COLUMN, 1));
	}
	$writer->startElement('sphinx:document'); 
	$writer->writeAttribute('id', $row['id']);
	foreach($row as $k=>$v){
		if($k=='id')continue;
		$writer->writeElement($k,$v);  
	}
	$writer->endElement();
}
$writer->endElement();
$writer->endDocument();