<?php
class Mnb_Model
{
    public function mnb_currency($vars)
    {
        $retData['eredmeny'] = 0;
        //$retData['eredmeny_month'] = 0;
        $retData['from_deviza'] = "EUR";
        $retData['to_deviza'] = "HUF";
        $retData['on_date'] = date("Y-m-d");
        $retData['sum'] = 0;

        //$retData['currency'] = "";
        //$retData['value_of_currency'] = "";

        if (isset($_POST['get_currency_on_day'])) {
            if (isset($_POST["from_deviza"]) && ($_POST["to_deviza"]) && ($_POST["on_date"]) && ($_POST["sum"])) {
                $from_deviza = $_POST["from_deviza"];
                $to_deviza = $_POST["to_deviza"];
                $on_date = $_POST["on_date"];
                $sum = $_POST["sum"];

                $retData['from_deviza'] = $from_deviza;
                $retData['to_deviza'] = $to_deviza;
                $retData['on_date'] = $on_date;
                $retData['sum'] = $sum;


                unset($currates);

                $options = array(
                    //'keep_alive' => false,
                    'trace' => true,
                    //'connection_timeout' => 5000,
                    //'cache_wsdl' => WSDL_CACHE_NONE,
                );

                $client = new SoapClient("http://www.mnb.hu/arfolyamok.asmx?WSDL", $options);
                $currates = $client->GetExchangeRates(array('startDate' => $on_date, 'endDate' => $on_date, 'currencyNames' => "$from_deviza"));


                $dom_root = new DOMDocument();
                $dom_root->loadXML($currates->GetExchangeRatesResult);

                $searchNode = $dom_root->getElementsByTagName("Day");

                foreach ($searchNode as $searchNode) {

                    $rates = $searchNode->getElementsByTagName("Rate");

                    foreach ($rates as $rate) {
                        $unit_1 = (int)$rate->getAttribute('unit');
                        $currency_1 = $rate->getAttribute('curr');
                        $dev_rate = $rate->nodeValue;
                        $value_of_currency_1 = floatval(number_format(str_replace(",", ".", $dev_rate), 2));
                    }
                }

                $currates2 = $client->GetExchangeRates(array('startDate' => $on_date, 'endDate' => $on_date, 'currencyNames' => "$to_deviza"))->GetExchangeRatesResult;

                $dom_root = new DOMDocument();
                $dom_root->loadXML($currates2);

                $searchNode = $dom_root->getElementsByTagName("Day");

                foreach ($searchNode as $searchNode) {

                    $rates = $searchNode->getElementsByTagName("Rate");

                    foreach ($rates as $rate) {
                        $unit_2 = (int)$rate->getAttribute('unit');
                        $currency_2 = $rate->getAttribute('curr');
                        $dev_rate2 = $rate->nodeValue;
                        $value_of_currency_2 = floatval(number_format(str_replace(",", ".", $dev_rate2), 2));
                    }
                }

                if (isset($value_of_currency_1) or isset($value_of_currency_2)) {
                    $mnbDefaultCurrency = "HUF";
                    if ($from_deviza == $mnbDefaultCurrency and $to_deviza !== $mnbDefaultCurrency) {   // HUF - Deviza
                        $retData['eredmeny'] = ($sum / $value_of_currency_2) * $unit_2;
                    }
                    if ($from_deviza !== $mnbDefaultCurrency and $to_deviza == $mnbDefaultCurrency) {  // Deviza - HUF
                        $retData['eredmeny'] = ($value_of_currency_1 * $sum) / $unit_1;
                    }
                    if ($from_deviza !== $mnbDefaultCurrency and $to_deviza !== $mnbDefaultCurrency) {   // Deviza - Deviza
                        floatval($retData['eredmeny'] = number_format((number_format(($value_of_currency_1 * $unit_1), 2))
                            / (number_format(($value_of_currency_2
                                * $unit_2), 2))
                            * $sum, 2));
                    }
                    if ($from_deviza == $mnbDefaultCurrency and $to_deviza == $mnbDefaultCurrency) {   // HUF - HUF
                        $retData['eredmeny'] = $value_of_currency_1 * $sum;
                    }
                }
            }
        }



        if (isset($_POST['get_currency_on_month'])) {
            if (isset($_POST["from_deviza_month"]) && ($_POST["to_deviza_month"]) && ($_POST["on_month"])) {
                $from_deviza = $_POST["from_deviza_month"];
                $to_deviza = $_POST["to_deviza_month"];
                $on_date = $_POST["on_month"] . "-01";
                $date = new DateTime($on_date);
                $date->modify('last day of this month');
                $end_date = $date->format('Y-m-d');

                $currencys = $from_deviza . "," . $to_deviza;

                $retData['from_deviza_month'] = $from_deviza;
                $retData['to_deviza_month'] = $to_deviza;
                $retData['on_month'] = $on_date;
                //$retData['month_currency'] = array();

                unset($currates);

                $options = array(
                    //'keep_alive' => false,
                    'trace' => true,
                    //'connection_timeout' => 5000,
                    //'cache_wsdl' => WSDL_CACHE_NONE,
                );

                $client = new SoapClient("http://www.mnb.hu/arfolyamok.asmx?WSDL", $options);
                $currates = $client->GetExchangeRates(array('startDate' => $on_date, 'endDate' => $end_date, 'currencyNames' => "$currencys"));


                $dom_root = new DOMDocument();
                $dom_root->loadXML($currates->GetExchangeRatesResult);

                $searchNode = $dom_root->getElementsByTagName("Day");

                $dev_rule = true;
                $retData['date'] = array();
                $retData['from_deviza_month'] = array();
                $retData['to_deviza_month'] = array();
                $retData['unit1_month'] = array();
                $retData['unit2_month'] = array();
                $retData['value_of_currency1_month'] = array();
                $retData['value_of_currency2_month']  = array();

                foreach ($searchNode as $searchNode) {
                    $date = $searchNode->getAttribute('date');
                    array_push($retData['date'], $date);

                    $rates = $searchNode->getElementsByTagName("Rate");


                    foreach ($rates as $rate) {
                        $unit_1 = (int)$rate->getAttribute('unit');
                        $currency_1 = $rate->getAttribute('curr');
                        $dev_rate = $rate->nodeValue;
                        $value_of_currency_1 = floatval(number_format(str_replace(",", ".", $dev_rate), 2));

                        if ($dev_rule == true) {
                            array_push($retData['unit1_month'], $unit_1);
                            array_push($retData['from_deviza_month'], $currency_1);
                            array_push($retData['value_of_currency1_month'], $value_of_currency_1);
                            $dev_rule = false;
                        } else {

                            array_push($retData['unit2_month'], $unit_1);
                            array_push($retData['to_deviza_month'], $currency_1);
                            array_push($retData['value_of_currency2_month'], $value_of_currency_1);
                            $dev_rule = true;
                        }
                    }
                }
            }
        }
        return $retData;
    }
}
