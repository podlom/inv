<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 5/6/20
 * Time: 20:34
 * Modified: 2025-05-30 14:48
 *
 * @author Taras Shkodenko <taras.shkodenko@gmail.com>
 *
 * @see https://www.codeofaninja.com/2014/06/google-maps-geocoding-example-php.html
 *
 */

define('API_KEY', 'AIzaSyAPN3Neq0YC-My56mfPKTtpzD-Q1U2OcVE');

function geocode2($address)
{
    $address = urlencode($address);

    $url = "https://maps.googleapis.com/maps/api/geocode/json?address={$address}&key=" . API_KEY;
    // echo '<!-- URL: ' . var_export($url, true) . ' -->' . PHP_EOL;

    $resp_json = file_get_contents($url);

    $resp = json_decode($resp_json, true);
    // echo '<!-- resp: ' . var_export($resp, true) . ' -->' . PHP_EOL;

    if ($resp['status'] == 'OK') {
        $formatted_address = isset($resp['results'][0]['formatted_address']) ? $resp['results'][0]['formatted_address'] : "";
        return $formatted_address;
    }

    return "";
}

if (isset($_REQUEST, $_REQUEST['addr'])
    && !empty($_REQUEST['addr'])
) {
    $geoData = geocode2($_REQUEST['addr']);
    if (!headers_sent()) {
        header('Access-Control-Allow-Origin: *');
        header('Content-Type: text/html; charset=utf-8');
    }
    die($geoData);
}

function geocode($address)
{
    // url encode the address
    $address = urlencode($address);

    // google map geocode api url
    $url = "https://maps.googleapis.com/maps/api/geocode/json?address={$address}&key=" . API_KEY; // AIzaSyChZXYKmVFq2u4AdTDDJhkm84Rgol5apt0";
    echo '<!-- URL: ' . var_export($url, true) . ' -->' . PHP_EOL;

    // get the json response
    $resp_json = file_get_contents($url);

    // decode the json
    $resp = json_decode($resp_json, true);
    echo '<!-- resp: ' . var_export($resp, true) . ' -->' . PHP_EOL;

    // response status will be 'OK', if able to geocode given address
    if ($resp['status'] == 'OK') {

        // get the important data
        $lati = isset($resp['results'][0]['geometry']['location']['lat']) ? $resp['results'][0]['geometry']['location']['lat'] : "";
        $longi = isset($resp['results'][0]['geometry']['location']['lng']) ? $resp['results'][0]['geometry']['location']['lng'] : "";
        $formatted_address = isset($resp['results'][0]['formatted_address']) ? $resp['results'][0]['formatted_address'] : "";

        // verify if data is complete
        if ($lati && $longi && $formatted_address) {

            // put the data in the array
            $data_arr = array();

            array_push(
                $data_arr,
                $lati,
                $longi,
                $formatted_address
            );

            return $data_arr;

        } else {
            return false;
        }

    } else {
        echo "<strong>ERROR: {$resp['status']}</strong>";
        return false;
    }
}

$lat = $lng = $addr = '';
if (isset($_POST, $_POST['address'])
    && !empty($_POST['address'])
) {
    $geoData = geocode($_POST['address']);
    if (is_array($geoData) && !empty($geoData)) {
        $lat = $geoData[0];
        $lng = $geoData[1];
        $addr = $geoData[2];
    }
}

?>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Live Demo of Google Maps Geocoding Example with PHP</title>

    <style>
        #gmap_canvas{
            width:100%;
            height:30em;
        }
    </style>

    <script type="text/javascript" src="https://maps.google.com/maps/api/js?key=<?php echo API_KEY; ?>"></script>

</head>
<body>

<?php
    if (!empty($lat) && !empty($lng) && !empty($addr)) {
?>
        <div id="gmap_canvas"></div>
<script type="text/javascript">

function init_map() {
    coonsole.log('lat: <?php echo $lat; ?>');
    coonsole.log('lng: <?php echo $lng; ?>');

    var myOptions = {
        zoom: 14,
        center: new google.maps.LatLng(<?php echo $lat; ?>, <?php echo $lng; ?>),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("gmap_canvas"), myOptions);
    marker = new google.maps.Marker({
        map: map,
        position: new google.maps.LatLng(<?php echo $lat; ?>, <?php echo $lng; ?>)
    });
    infowindow = new google.maps.InfoWindow({
        content: "<?php echo $addr; ?>"
    });
    google.maps.event.addListener(marker, "click", function () {
        infowindow.open(map, marker);
    });
    infowindow.open(map, marker);
}
google.maps.event.addDomListener(window, 'load', init_map);

</script>
<?php

    } else {

?><div id='address-examples'>
    <div>Address examples:</div>
    <div>1. G/F Makati Cinema Square, Pasong Tamo, Makati City</div>
    <div>2. 80 E.Rodriguez Jr. Ave. Libis Quezon City</div>
</div><?php

    }

    ?>

<form action="" method="post">
    <input type='text' name='address' placeholder='Enter any address here' />
    <input type='submit' value='Geocode!' />
</form>

</body>
</html>
