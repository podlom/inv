<?php

namespace Tinyurl;

use Skynar\BaseModel;
use Skynar\Model\Timestamps;
use Doctrine\ORM\Mapping as ORM;
use Skynar\Annotation\Sync;

/**
 * @ORM\Entity
 * @ORM\HasLifecycleCallbacks
 */
class Link extends BaseModel implements \JsonSerializable{
	use Timestamps;

   /**
    * @var integer
    *
    * @ORM\Column(type="integer")
    * @ORM\Id
    * @ORM\GeneratedValue(strategy="IDENTITY")
    */
   protected $id;

   /**
    * @var string
    * @Sync\Input
    * @ORM\Column(type="string")
    */
   protected $url;

   /**
    * @var int
    * @ORM\Column(type="integer")
    */
   protected $clicks=0;

   /**
    * @var string
    * @ORM\Column(type="string")
    */
   protected $action='';

   /**
    * @var array
    * @ORM\Column(type="json_array")
    */
   protected $data=[];


    /**
     * Get id.
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set url.
     *
     * @param string $url
     *
     * @return Link
     */
    public function setUrl($url)
    {
        $this->url = $url;

        return $this;
    }

    /**
     * Get url.
     *
     * @return string
     */
    public function getUrl()
    {
        return $this->url;
    }

    /**
     * Set clicks.
     *
     * @param int $clicks
     *
     * @return Link
     */
    public function setClicks($clicks)
    {
        $this->clicks = $clicks;

        return $this;
    }

    /**
     * Get clicks.
     *
     * @return int
     */
    public function getClicks()
    {
        return $this->clicks;
    }

    /**
     * Set action.
     *
     * @param string $action
     *
     * @return Link
     */
    public function setAction($action)
    {
        $this->action = $action;

        return $this;
    }

    /**
     * Get action.
     *
     * @return string
     */
    public function getAction()
    {
        return $this->action;
    }

    /**
     * Set data.
     *
     * @param array $data
     *
     * @return Link
     */
    public function setData($data)
    {
        $this->data = $data;

        return $this;
    }

    /**
     * Get data.
     *
     * @return array
     */
    public function getData()
    {
        return $this->data;
    }

    public function get($name, $default=null)
    {
        return $this->data[$name] ?? $default;
    }

    public function set($name, $value)
    {
        $this->data[$name] = $value;
        return $this;
    }

    public function jsonSerialize(){
        return [
            'id'=>$this->getId(),
            'target'=>$this->getUrl(),
            'code'=>base_convert($this->getId(),10,36),
            'action'=>$this->getAction()
        ];
    }

}
