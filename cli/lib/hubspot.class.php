<?php


class Hubspot
{
    const APP_ID = 194128;

    const OWNER_ID = 36382326;

    const PORTAL_ID = 1982701;

    private $errorLogFile = null;

    private $db = null;

    private $settings = [];

    private $hapiKey = null;

    private $hubRespData = null;

    private $hubRespCode = null;

    private $hubRespErrors = null;

    private $owners = [];

    public function __construct($settings, $db)
    {
        $this->setErrorLogFile();
        $this->settings = $settings;
        if (!isset($settings['hubspot']) || !isset($settings['hubspot']['api_key'])) {
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Error HubSpot CRM settings not configured: ' . var_export($settings, 1) . PHP_EOL ;
            error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
        }
        $this->hapiKey = $settings['hubspot']['api_key'];
        $this->db = $db;
        $this->owners = $this->setOwners();
    }

    public function getErrorLogFile()
    {
        return $this->errorLogFile;
    }

    /**
     * Add new contact
     * @see: https://developers.hubspot.com/docs/methods/contacts/create_contact
     *
     * @param array $data
     * @return array|string
     */
    public function addContact($data)
    {
        // TODO: check required fields
        $arrData = [
            'properties' => [
                [
                    'property' => 'email',
                    'value' => $data['email'],
                ],
                [
                    'property' => 'firstname',
                    'value' => $data['firstname'],
                ],
                [
                    'property' => 'lastname',
                    'value' => $data['lastname'],
                ],
                /* [
                    'property' => 'phone',
                    'value' => $data['phone'],
                ] */
            ]
        ];
        if (isset($data['phone']) && !empty($data['phone'])) {
            $arrData['properties'][] = [
                'property' => 'phone',
                'value' => $data['phone'],
            ];
        }
        // source
        if (isset($data['source']) && !empty($data['source'])) {
            $arrData['properties'][] = [
                'property' => 'source',
                'value' => $data['source'],
            ];
        }
        //
        //
        //
        if (isset($data['website']) && !empty($data['website'])) {
            $arrData['properties'][] = [
                'property' => 'website',
                'value' => $data['website'],
            ];
        }
        if (isset($data['company']) && !empty($data['company'])) {
            $arrData['properties'][] = [
                'property' => 'company',
                'value' => $data['company'],
            ];
        }
        if (isset($data['jobtitle']) && !empty($data['jobtitle'])) {
            $arrData['properties'][] = [
                'property' => 'jobtitle',
                'value' => $data['jobtitle'],
            ];
        }
        if (isset($data['address']) && !empty($data['address'])) {
            $arrData['properties'][] = [
                'property' => 'address',
                'value' => $data['address'],
            ];
        }
        if (isset($data['city']) && !empty($data['city'])) {
            $arrData['properties'][] = [
                'property' => 'city',
                'value' => $data['city'],
            ];
        }
        if (isset($data['zip']) && !empty($data['zip'])) {
            $arrData['properties'][] = [
                'property' => 'zip',
                'value' => $data['zip'],
            ];
        }
        // Стадии инвестирования
        if (isset($data['stages']) && !empty($data['stages'])) {
            $arrData['properties'][] = [
                'property' => 'stages',
                'value' => $data['stages'],
            ];
        }
        // Отрасль
        if (isset($data['sector']) && !empty($data['sector'])) {
            $arrData['properties'][] = [
                'property' => 'sector',
                'value' => $data['sector'],
            ];
        }
        // Объемы инвестирования
        if (isset($data['value']) && !empty($data['value'])) {
            $arrData['properties'][] = [
                'property' => 'value',
                'value' => $data['value'],
            ];
        }
        // Регион
        if (isset($data['region']) && !empty($data['region'])) {
            $arrData['properties'][] = [
                'property' => 'region',
                'value' => $data['region'],
            ];
        }
        // Сильные стороны
        if (isset($data['strengths']) && !empty($data['strengths'])) {
            $arrData['properties'][] = [
                'property' => 'strengths',
                'value' => $data['strengths'],
            ];
        }
        // Тип клиента
        if (isset($data['type_of_client']) && !empty($data['type_of_client'])) {
            $arrData['properties'][] = [
                'property' => 'type_of_client',
                'value' => $data['type_of_client'],
            ];
        }
        // Форма инвестирования
        if (isset($data['form_of_investment']) && !empty($data['form_of_investment'])) {
            $arrData['properties'][] = [
                'property' => 'form_of_investment',
                'value' => $data['form_of_investment'],
            ];
        }
        // Подписка
        if (isset($data['mailing']) && !empty($data['mailing'])) {
            $arrData['properties'][] = [
                'property' => 'mailing',
                'value' => $data['mailing'],
            ];
        }
        //
        //
        //
        if (isset($data['hubspot_owner_id']) && !empty($data['hubspot_owner_id'])) {
            $arrData['properties'][] = [
                'property' => 'hubspot_owner_id',
                'value' => $data['hubspot_owner_id'],
            ];
        }
        $resp = $this->query('/contacts/v1/contact?hapikey=' . $this->hapiKey, __METHOD__, $arrData);
        if ($this->hubRespCode == 200) {
            return $resp;
        } else {
            return [
                'hubRespCode' => $this->hubRespCode,
                'result' => $resp,
            ];
        }
    }

    /**
     * Update contact information
     * @see: https://developers.hubspot.com/docs/methods/contacts/update_contact
     *
     * @param array $data
     * @return bool|string|array
     */
    public function updateContact($data)
    {
        // TODO: check required fields
        $arrData = [];
        $arrData['properties'] = [];
        //
        if (isset($data['email']) && !empty($data['email'])) {
            $arrData['properties'][] = [
                'property' => 'email',
                'value' => $data['email'],
            ];
        }
        if (isset($data['firstname']) && !empty($data['firstname'])) {
            $arrData['properties'][] = [
                'property' => 'firstname',
                'value' => $data['firstname'],
            ];
        }
        if (isset($data['lastname']) && !empty($data['lastname'])) {
            $arrData['properties'][] = [
                'property' => 'lastname',
                'value' => $data['lastname'],
            ];
        }
        if (isset($data['website']) && !empty($data['website'])) {
            $arrData['properties'][] = [
                'property' => 'website',
                'value' => $data['website'],
            ];
        }
        if (isset($data['lifecyclestage']) && !empty($data['lifecyclestage'])) {
            $arrData['properties'][] = [
                'property' => 'lifecyclestage',
                'value' => $data['lifecyclestage'],
            ];
        }
        if (isset($data['mailing'])) {
            $arrData['properties'][] = [
                'property' => 'mailing',
                'value' => $data['mailing'],
            ];
        }
        if (isset($data['jobtitle']) && !empty($data['jobtitle'])) {
            $arrData['properties'][] = [
                'property' => 'jobtitle',
                'value' => $data['jobtitle'],
            ];
        }
        //
        $resp = $this->query('/contacts/v1/contact/vid/' . $data['vid'] . '/profile?hapikey=' . $this->hapiKey, __METHOD__, $arrData);
        if ($this->hubRespCode == 204) {
            return $resp;
        } else {
            return [
                'respCode' => $this->hubRespCode,
                'respData' => $this->hubRespData,
                'respErr' => $this->hubRespErrors,
            ];
        }
    }

    /**
     * Add or update contact
     * @see: https://developers.hubspot.com/docs/methods/contacts/create_or_update
     * @param array $data
     * @return array|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function addOrUpdateContact($data)
    {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Debug $data val: ' . var_export($data, true) . PHP_EOL;
        error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
        //
        if (empty($data['email'])) {
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Error: empty email' . PHP_EOL;
            error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
            return false;
        }
        if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Error: not valid email provided: ' . var_export($data['email'], 1) . PHP_EOL;
            error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
            return false;
        }
        // TODO: check required fields
        $arrData = [
            'properties' => [
                [
                    'property' => 'email',
                    'value' => $data['email'],
                ],
                [
                    'property' => 'firstname',
                    'value' => $data['firstname'],
                ],
            ]
        ];
        if (isset($data['lastname']) && !empty($data['lastname'])) {
            $arrData['properties'][] = [
                'property' => 'lastname',
                'value' => $data['lastname'],
            ];
        }
        if (isset($data['phone']) && !empty($data['phone'])) {
            $arrData['properties'][] = [
                'property' => 'phone',
                'value' => $data['phone'],
            ];
        }
        if (isset($data['website']) && !empty($data['website'])) {
            $arrData['properties'][] = [
                'property' => 'website',
                'value' => $data['website'],
            ];
        }
        if (isset($data['company']) && !empty($data['company'])) {
            $arrData['properties'][] = [
                'property' => 'company',
                'value' => $data['company'],
            ];
        }
        if (isset($data['jobtitle']) && !empty($data['jobtitle'])) {
            $arrData['properties'][] = [
                'property' => 'jobtitle',
                'value' => $data['jobtitle'],
            ];
        }
        if (isset($data['address']) && !empty($data['address'])) {
            $arrData['properties'][] = [
                'property' => 'address',
                'value' => $data['address'],
            ];
        }
        if (isset($data['city']) && !empty($data['city'])) {
            $arrData['properties'][] = [
                'property' => 'city',
                'value' => $data['city'],
            ];
        }
        if (isset($data['zip']) && !empty($data['zip'])) {
            $arrData['properties'][] = [
                'property' => 'zip',
                'value' => $data['zip'],
            ];
        }
        if (isset($data['source']) && !empty($data['source'])) {
            $arrData['properties'][] = [
                'property' => 'source',
                'value' => $data['source'],
            ];
        }
        // Стадии инвестирования
        if (isset($data['stages']) && !empty($data['stages'])) {
            $arrData['properties'][] = [
                'property' => 'stages',
                'value' => $data['stages'],
            ];
        }
        // Отрасль
        if (isset($data['sector']) && !empty($data['sector'])) {
            $arrData['properties'][] = [
                'property' => 'sector',
                'value' => $data['sector'],
            ];
        }
        // Объемы инвестирования
        if (isset($data['value']) && !empty($data['value'])) {
            $arrData['properties'][] = [
                'property' => 'value',
                'value' => $data['value'],
            ];
        }
        // Регион
        if (isset($data['region']) && !empty($data['region'])) {
            $arrData['properties'][] = [
                'property' => 'region',
                'value' => $data['region'],
            ];
        }
        // Сильные стороны
        if (isset($data['strengths']) && !empty($data['strengths'])) {
            $arrData['properties'][] = [
                'property' => 'strengths',
                'value' => $data['strengths'],
            ];
        }
        // Тип клиента
        if (isset($data['type_of_client']) && !empty($data['type_of_client'])) {
            $arrData['properties'][] = [
                'property' => 'type_of_client',
                'value' => $data['type_of_client'],
            ];
        }
        // Форма инвестирования
        if (isset($data['form_of_investment']) && !empty($data['form_of_investment'])) {
            $arrData['properties'][] = [
                'property' => 'form_of_investment',
                'value' => $data['form_of_investment'],
            ];
        }
        // Подписка
        if (isset($data['mailing']) && !empty($data['mailing'])) {
            $arrData['properties'][] = [
                'property' => 'mailing',
                'value' => $data['mailing'],
            ];
        }
        //
        if (isset($data['hubspot_owner_id']) && !empty($data['hubspot_owner_id'])) {
            $arrData['properties'][] = [
                'property' => 'hubspot_owner_id',
                'value' => $data['hubspot_owner_id'],
            ];
        }
        $resp = $this->query('/contacts/v1/contact/createOrUpdate/email/' . urlencode($data['email']) . '/?hapikey=' . $this->hapiKey, __METHOD__, $arrData);
        if ($this->hubRespCode == 200) {
            return $resp;
        } else {
            return [
                'hubRespCode' => $this->hubRespCode,
                'result' => $resp,
            ];
        }
    }

    /**
     * Get all contact properties
     * @see: https://developers.hubspot.com/docs/methods/contacts/v2/get_contacts_properties
     * @return bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getAllContactProperties()
    {
        $arrData = [];
        $resp = $this->query('/properties/v1/contacts/properties?hapikey=' . $this->hapiKey, __METHOD__, $arrData);
        return $resp;
    }

    /**
     * Get Contact Property by Name
     * @see: https://developers.hubspot.com/docs/methods/companies/get_contact_property
     * @param string $name
     * @return bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getContactPropertyByName($name)
    {
        if (empty($name)) {
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Error: property name' . PHP_EOL;
            error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
            return false;
        }
        $arrData = [];
        $propName = urlencode($name);
        $resp = $this->query('/properties/v1/contacts/properties/named/' . $propName . '?hapikey=' . $this->hapiKey, __METHOD__, $arrData);
        // return $resp;
        if ($this->hubRespCode == 200) {
            return $resp;
        } else {
            return [
                'hubRespCode' => $this->hubRespCode,
                'result' => $resp,
            ];
        }
    }

    /**
     * @see: https://developers.hubspot.com/docs/methods/contacts/v2/update_contact_property
     * @param array $data
     * @return array|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function updateContactProperty($data)
    {
        if (empty($data['name'])) {
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Error: empty property name' . PHP_EOL;
            error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
            return false;
        }
        // @see: https://stackoverflow.com/questions/5043525/php-curl-http-put
        $reqConfig = [
            'method' => 'PUT',
            'timeout' => 30,
            'max_redirects' => 10,
        ];
        /**
         * @example JSON: {
         *   "name": "originalprop",
         *   "groupName": "analyticsinformation",
         *   "description": "",
         *   "fieldType": "text",
         *   "formField": true,
         *   "type": "string",
         *   "displayOrder": 16,
         *   "label": "Fresh Method Prop"
         *   }
         */
        // TODO: fill in contact property data
        $arrData = [
            $data
        ];
        //
        $propName = urlencode($data['name']);
        // /properties/v1/contacts/properties/named/custom_field?hapikey=
        $resp = $this->query('/properties/v1/contacts/properties/named/' . $propName . '?hapikey=' . $this->hapiKey, __METHOD__, $arrData, $reqConfig);
        if ($this->hubRespCode == 200) {
            return $resp;
        } else {
            return [
                'hubRespCode' => $this->hubRespCode,
                'result' => $resp,
            ];
        }
    }

    /**
     * Update contact property data by name
     * @param string $name
     * @param array $data
     * @return array|bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function updateContactPropertyByName($name, $data)
    {
        if (empty($name)) {
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Error: empty property name' . PHP_EOL;
            error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
            return false;
        }
        $reqConfig = [
            'method' => 'PUT',
            'timeout' => 30,
        ];
        $arrData = [
            $data
        ];
        //
        $propName = urlencode($name);
        $resp = $this->query('/properties/v1/contacts/properties/named/' . $propName . '?hapikey=' . $this->hapiKey, __METHOD__, $arrData, $reqConfig);
        if ($this->hubRespCode == 200) {
            return $resp;
        } else {
            return [
                'dataSent' => serialize($arrData),
                'hubRespCode' => $this->hubRespCode,
                'result' => $resp,
            ];
        }
    }

    public function getContactPropertyGroups()
    {
        $arrData = [];
        $resp = $this->query('/properties/v1/contacts/groups?hapikey=' . $this->hapiKey, __METHOD__, $arrData);
        return $resp;
    }

    /**
     * Set owners
     * @see: https://developers.hubspot.com/docs/methods/owners/get_owners
     * @return bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    protected function setOwners()
    {
        $arrData = [];
        $resp = $this->query('/owners/v2/owners?hapikey=' . $this->hapiKey, __METHOD__, $arrData);
        return $resp;
    }

    /**
     * Get owners
     * @return array|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getOwners()
    {
        return $this->owners;
    }

    public function getOwnerId()
    {
        return self::OWNER_ID;
    }

    public function getTimeStamp()
    {
        $timeStart = microtime(true);
        $aT = explode('.', $timeStart);
        $sT = substr($aT[0] . $aT[1], 0, 13);
        if (strlen($sT) < 13) {
            $sT = str_pad($sT, 13, "0");
        }
        return $sT;
    }

    /**
     * Search contact by email
     * @see: https://developers.hubspot.com/docs/methods/contacts/get_contact_by_email
     *
     * @param string $email
     * @param null|array $params
     * @return bool|string
     */
    public function findContactByEmail($email, $params = null)
    {
        if (empty($email)) {
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Error: empty email' . PHP_EOL;
            error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
            return false;
        }
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Error: not valid email provided: ' . var_export($email, 1) . PHP_EOL;
            error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
            return false;
        }
        $email = urlencode($email);
        $uri = '/contacts/v1/contact/email/' . $email . '/profile?hapikey=' . $this->hapiKey;
        if (!is_null($params) && is_array($params) && !empty($params)) {
            if (isset($params['propertyMode']) && !empty($params['propertyMode'])) {
                $uri .= '&propertyMode=' . $params['propertyMode'];
            }
            if (isset($params['properties']) && !empty($params['properties'])) {
                $uri .= $params['properties'];
            }
        }
        $resp = $this->query($uri, __METHOD__, []);
        return $resp;
    }

    /**
     * Search contact by phone
     * @see: https://developers.hubspot.com/docs/methods/contacts/search_contacts
     *
     * @param string $phone
     * @return bool|string|null
     */
    public function findContactByPhone($phone)
    {
        $phone = urlencode($this->sanitizePhoneNumber($phone));
        // @example: https://api.hubapi.com/contacts/v1/search/query?q=testingapis&hapikey=demo
        $uri = '/contacts/v1/search/query?q=' . $phone . '&hapikey=' . $this->hapiKey;
        $resp = $this->query($uri, __METHOD__, []);
        return $resp;
    }

    /**
     * Get contact by id
     * @see: https://developers.hubspot.com/docs/methods/contacts/get_contact
     *
     * @param int $contactId
     * @return bool|string|null
     */
    public function getContactById($contactId)
    {
        // @example: https://api.hubapi.com/contacts/v1/contact/vid/3234574/profile?hapikey=demo
        $resp = $this->query('/contacts/v1/contact/vid/' . (int)$contactId . '/profile?hapikey=' . $this->hapiKey, __METHOD__, []);
        if (!empty($resp)) {
            return $resp;
        }
        return false;
    }

    /**
     * Get Email Subscriber Contacts
     * @param $arrData
     * @return array|bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getEmailSubscribers($arrData)
    {
        // @see: https://developers.hubspot.com/docs/methods/contacts/search_contacts
        //
        $uri = '/contacts/v1/lists/all/contacts/all?hapikey=' . $this->hapiKey;
        //
        // @example: $arrCont = [
        //        'count' => 100,
        //        'property' => 'mailing',
        //        'propertyMode' => 'value_only',
        //    ];
        //
        if (isset($arrData['count'])) {
            $uri .= '&count=' . intval($arrData['count']);
        }
        if (isset($arrData['property1'])) {
            $uri .= '&property=' . $arrData['property1'];
        }
        if (isset($arrData['property2'])) {
            $uri .= '&property=' . $arrData['property2'];
        }
        if (isset($arrData['property3'])) {
            $uri .= '&property=' . $arrData['property3'];
        }
        if (isset($arrData['property4'])) {
            $uri .= '&property=' . $arrData['property4'];
        }
        if (isset($arrData['propertyMode'])) {
            $uri .= '&propertyMode=' . $arrData['propertyMode'];
        }
        if (isset($arrData['vid-offset'])) {
            $uri .= '&vid-offset=' . $arrData['vid-offset'];
        }
        $resp = $this->query($uri, __METHOD__, []);

        if ($this->hubRespCode == 200) {
            return $resp;
        } else {
            return [
                'dataSent' => serialize($arrData),
                'hubRespCode' => $this->hubRespCode,
                'result' => $resp,
            ];
        }
    }

    /**
     * Get contacts in a list
     * @param int $listId
     * @param int $count
     * @param null|int $offsetVid
     * @return array|bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getContactsInList($listId, $count = 100, $offsetVid = null)
    {
        $listId = intval($listId);
        //
        // @see: https://developers.hubspot.com/docs/methods/lists/get_list_contacts
        //
        // @example URL: https://api.hubapi.com/contacts/v1/lists/226468/contacts/all?hapikey=demo
        //
        if (!is_null($offsetVid)) {
            $uri = '/contacts/v1/lists/' . $listId . '/contacts/all?hapikey=' . $this->hapiKey . '&count=' . $count . '&vidOffset=' . $offsetVid;
        } else {
            $uri = '/contacts/v1/lists/' . $listId . '/contacts/all?hapikey=' . $this->hapiKey . '&count=' . $count;
        }

        $resp = $this->query($uri, __METHOD__, []);

        if ($this->hubRespCode == 200) {
            return $resp;
        } else {
            return [
                'listId' => $listId,
                'hubRespCode' => $this->hubRespCode,
                'result' => $resp,
            ];
        }
    }

    /**
     * Get company by id
     * @see: https://developers.hubspot.com/docs/methods/companies/get_company
     * @param int $companyId
     * @return bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getCompanyById($companyId)
    {
        $resp = $this->query('/companies/v2/companies/' . (int)$companyId . '?hapikey=' . $this->hapiKey, __METHOD__, []);
        if (!empty($resp)) {
            return $resp;
        }
        return false;
    }

    /**
     * Add a deal
     * @see: https://developers.hubspot.com/docs/methods/deals/create_deal
     *
     * @param array $data
     * @return array|string
     */
    public function addDeal($data)
    {
        // TODO: check data
        $arrData = [
            'associations' => [
                'associatedCompanyIds' => [
                    $data['associatedCompanyIds']
                ],
                'associatedVids' => [
                    $data['associatedVids']
                ],
            ],
            'properties' => [
                [
                    "value" => $data["dealname"],
                    "name" => "dealname",
                ],
                [
                    "value" => $data["dealstage"],
                    "name" => "dealstage",
                ],
                [
                    "value" => $data["pipeline"],
                    "name" => "pipeline",
                ],
                /* [
                    "value" => $data["hubspot_owner_id"],
                    "name" => "hubspot_owner_id",
                ],
                [
                    "value" => $data["closedate"],
                    "name" => "closedate",
                ],
                [
                    "value" => $data["amount"],
                    "name" => "amount",
                ],
                [
                    "value" => $data["dealtype"],
                    "name" => "dealtype",
                ], */
            ]
        ];
        if (isset($data['amount']) && !empty($data['amount'])) {
            $arrData['properties']['amount'] = [
                "value" => $data['amount'],
                "name" => 'amount',
            ];
        }
        if (isset($data['hubspot_owner_id']) && !empty($data['hubspot_owner_id'])) {
            $arrData['properties']['hubspot_owner_id'] = [
                "value" => $data['hubspot_owner_id'],
                "name" => 'hubspot_owner_id',
            ];
        }
        if (isset($data['closedate'])) {
            $arrData['properties']['closedate'] = [
                "value" => $data["closedate"],
                "name" => "closedate",
            ];
        }
        if (isset($data['dealtype'])) {
            $arrData['properties']['dealtype'] = [
                "value" => $data["dealtype"],
                "name" => "dealtype",
            ];
        }
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal data: ' . var_export($arrData, 1) . PHP_EOL;
        error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
        //
        // @example: 'https://api.hubapi.com/deals/v1/deal?hapikey=demo'
        $uri = '/deals/v1/deal?hapikey=' . $this->hapiKey;
        $resp = $this->query($uri, __METHOD__, $arrData);
        if ($this->hubRespCode == 200) {
            return $resp;
        } else {
            return [
                'dataSent' => serialize($data),
                'hubRespCode' => $this->hubRespCode,
                'result' => $resp,
            ];
        }
    }

    /**
     * Update a deal
     * @see: https://developers.hubspot.com/docs/methods/deals/update_deal
     *
     * @param array $data
     * @return array|string
     */
    public function updateDeal($data)
    {
        /** @example: $arrData = [
            'properties' => [
                [
                    "value" => $data["amount"],
                    "name" => "amount",
                ],
            ]
        ]; */
        // TODO: check data
        foreach ($data as $k1 => $v1) {
            if ($k1 !== 'dealId') {
                $arrData['properties'][] = [
                    'value' => $v1,
                    'name' => $k1,
                ];
            }
        }
        $uri = '/deals/v1/deal/' . (int)$data['dealId'] . '?hapikey=' . $this->hapiKey;
        $resp = $this->query($uri, __METHOD__, $arrData, ['method' => 'PUT']);
        if (!empty($resp)) {
            return $resp;
        } else {
            return [
                'dataSent' => serialize($data),
                'hubRespCode' => $this->hubRespCode,
                'result' => $resp,
            ];
        }
    }

    /**
     * Get deal by id
     * @see: https://developers.hubspot.com/docs/methods/deals/get_deal
     *
     * @param int $dealId
     * @return bool|string|null
     */
    public function getDealById($dealId)
    {
        $resp = $this->query('/deals/v1/deal/' . (int)$dealId . '?hapikey=' . $this->hapiKey, __METHOD__, []);
        if (!empty($resp)) {
            return $resp;
        }
        return false;
    }

    /**
     * Get deal pipelines
     * @see: https://developers.hubspot.com/docs/methods/deal-pipelines/get-all-deal-pipelines
     * @return bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getDealPipelines()
    {
        $resp = $this->query('/deals/v1/pipelines?hapikey=' . $this->hapiKey, __METHOD__, []);
        if (!empty($resp)) {
            return $resp;
        }
        return false;
    }

    /**
     * Get recently created deals
     * @see: https://developers.hubspot.com/docs/methods/deals/get_deals_created
     * @return bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getRecentlyCreatedDeals($reqData = [])
    {
        $resp = $this->query('/deals/v1/deal/recent/created?hapikey=' . $this->hapiKey, __METHOD__, $reqData);
        if (!empty($resp)) {
            return $resp;
        }
        return false;
    }

    /**
     * Get recently modified deals
     * @see: https://developers.hubspot.com/docs/methods/deals/get_deals_modified
     * @param array $reqData
     * @return bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getRecentlyModifiedDeals($reqData = [])
    {
        $resp = $this->query('/deals/v1/deal/recent/modified?hapikey=' . $this->hapiKey, __METHOD__, $reqData);
        if (!empty($resp)) {
            return $resp;
        }
        return false;
    }

    public function addDealNote($data)
    {
        /** @example: $arrData = [ "engagement": {
        "active": true,
        "ownerId": 1,
        "type": "NOTE",
        "timestamp": 1409172644778
        },
        "associations": {
        "contactIds": [2],
        "companyIds": [ ],
        "dealIds": [ ],
        "ownerIds": [ ]
        },
        "attachments": [
        {
        "id": 4241968539
        }
        ],
        "metadata": {
        "body": "note body"
        } ]; */
        // TODO: check data
        $uri = '/engagements/v1/engagements?hapikey=' . $this->hapiKey;
        $resp = $this->query($uri, __METHOD__, $data);
        if (!empty($resp)) {
            return $resp;
        }
        return false;
    }

    /**
     * Get App webhook settings
     * @see: https://developers.hubspot.com/docs/methods/webhooks/webhooks-overview
     * @return bool|string|null
     *
     * @author Taras Shkodenko <ts@doagency.net>
     */
    public function getWebhookSettings()
    {
        $resp = $this->query('/webhooks/v1/' . self::APP_ID . '/settings?hapikey=' . $this->hapiKey, __METHOD__, []);
        if (!empty($resp)) {
            return $resp;
        }
        return false;
    }

    /**
     * Sanitize phone number
     * @param string $str
     * @return string|string[]|null
     */
    private function sanitizePhoneNumber($str)
    {
        $phoneNumber = preg_replace("/\D/", '', $str);
        /* if (strlen($phoneNumber) == 10) {
            $phoneNumber = '38' . $phoneNumber;
        } */
        return $phoneNumber;
    }

    private function setErrorLogFile()
    {
        $this->errorLogFile = realpath(__DIR__ . '/../') . '/logs/hubspot-class_' . date('Y-m-d') . '.log';
    }

    private function query($uri, $method = '', $reqData = [], $reqConf = [])
    {
        $isPostRequest = $isPutRequest = false;
        if (!empty($reqData)) {
            $postJson = json_encode($reqData);
            $isPostRequest = true;
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Sending POST JSON: ' . var_export($postJson, true) . PHP_EOL;
            error_log($msg . PHP_EOL, 3, $this->getErrorLogFile());
        }
        if (isset($reqConf['method']) && ($reqConf['method'] == 'PUT')) {
            $isPostRequest = false;
            $isPutRequest = true;
            $putJson = json_encode($reqData);
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Sending PUT JSON: ' . var_export($putJson, true) . PHP_EOL;
            error_log($msg . PHP_EOL, 3, $this->getErrorLogFile());
        }
        $url = 'https://api.hubapi.com' . $uri;
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' URL: ' . $url . PHP_EOL;
        error_log( $msg . PHP_EOL, 3, $this->getErrorLogFile() );
        $ch = @curl_init();
        if ($isPostRequest) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $postJson);
            curl_setopt($ch, CURLOPT_HTTPHEADER, ["Content-Type: application/json"]);
        }
        if ($isPutRequest) {
            // CURLOPT_ENCODING
            curl_setopt($ch, CURLOPT_ENCODING, "");
            // HTTP Protocol VERSION to 1.1
            curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
            // Request type
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
            // Request data
            curl_setopt($ch, CURLOPT_POSTFIELDS, $putJson);
            // Headers
            curl_setopt($ch, CURLOPT_HTTPHEADER, [
                "Content-Type: application/json",
                "cache-control: no-cache",
            ]);
        }
        //
        if (isset($reqConf['timeout'])) {
            // Timeout
            curl_setopt($ch, CURLOPT_TIMEOUT, $reqConf['timeout']);
        }
        //
        if (isset($reqConf['max_redirects'])) {
            // Max redirects
            curl_setopt($ch, CURLOPT_MAXREDIRS, $reqConf['max_redirects']);
        }
        //
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        //
        curl_setopt($ch, CURLOPT_COOKIEFILE, $this->getCookieJarFile());
        curl_setopt($ch, CURLOPT_COOKIEJAR, $this->getCookieJarFile());
        //
        $this->hubRespData = @curl_exec($ch);
        $this->hubRespCode = @curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $this->hubRespErrors = curl_error($ch);
        curl_close($ch);
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ .
            ' curl Errors: ' . var_export($this->hubRespErrors, 1) . PHP_EOL .
            ' Status code: ' . var_export($this->hubRespCode, 1) . PHP_EOL .
            ' Response: ' . var_export($this->hubRespData, 1) . PHP_EOL;
        error_log($msg . PHP_EOL, 3, $this->getErrorLogFile());
        //
        return $this->hubRespData;
    }

    private function getCookieJarFile()
    {
        return dirname(__FILE__) . '/_hubspot_cookie_' . $this->hapiKey . '.txt';
    }

    public static function cleanPhoneNumber($str)
    {
        $maxLen = 12;
        $phoneNumber = preg_replace("/\D/", '', $str);
        $len = strlen($phoneNumber);
        if ($len > $maxLen) {
            $cutLen = $len - $maxLen;
            $phoneNumber = substr($phoneNumber, $cutLen);
        }
        return $phoneNumber;
    }

    public function getPortalId()
    {
        return self::PORTAL_ID;
    }
}
