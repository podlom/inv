<?php
/**
 * @package Skynar
 * @version 0.1
 * @link http://skynar.co/
 * @author Taras Shkodenko <taras@shkodenko.com>
 * @copyright 2021
 */
 
namespace Croudinvesting;


use Doctrine\ORM\Mapping as ORM;
use Skynar\Annotation\Sync;
use Skynar\Exception\InvalidArgument;


/**
 * Croudinvesting model
 * @ORM\Entity
 * @ORM\Table(name="croudinvesting")
 */
class Croudinvesting extends \Skynar\BaseModel
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    protected $id;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=64)
     */
    protected $first_name;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=255)
     */
    protected $email;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=32)
     */
    protected $phone;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=32)
     */
    protected $last_name;

    /**
     * @var float
     *
     * @Sync\Input
     * @ORM\Column(type="float", nullable=true)
     */
    protected $plan_to_invest = 0;

    /**
     * @var boolean
     *
     * @Sync\Input
     * @ORM\Column(type="boolean", options={"default":false} )
     */
    protected $additional_info = false;

    /**
     * @var DateTime
     *
     * @Sync\Input
     * @ORM\Column(name="published", type="datetime" )
     */
    protected $published;

    /**
     * @var DateTime
     *
     * @Sync\Input
     * @ORM\Column(name="created", type="datetime" )
     */
    protected $created;

    /**
     * @var DateTime
     *
     * @Sync\Input
     * @ORM\Column(name="updated", type="datetime" )
     */
    protected $updated;

    /**
     * @var integer
     *
     * @ORM\Column(type="integer")
     */
    protected $status = 1;

    /**
     * TODO: remove it ?
     *
     * @var
     */
    protected $init;

    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Getter first name
     *
     * @return string
     */
    public function getFirstName(): string
    {
        if (!isset($this->first_name) || empty($this->first_name)) {
            return '';
        }
        return $this->first_name;
    }

    /**
     * Setter first name
     *
     * @param string $first_name
     *
     * @return Croudinvesting
     */
    public function setFirstName(string $first_name): Croudinvesting
    {
        $this->first_name = $first_name;

        return $this;
    }

    /**
     * Get croudinvesting email
     *
     * @return string
     */
    public function getEmail(): string
    {
        if (!isset($this->email) || empty($this->email)) {
            return '';
        }
        return $this->email;
    }

    /**
     * @param string $email
     *
     * @return Croudinvesting
     */
    public function setEmail(string $email): Croudinvesting
    {
        $this->email = $email;

        return $this;
    }

    /**
     * Set phone number
     *
     * @param string $phone
     *
     * @return Croudinvesting
     */
    public function setPhone($phone): Croudinvesting
    {
        $this->phone = $phone;

        return $this;
    }

    /**
     * Get phone number
     *
     * @return string
     */
    public function getPhone()
    {
        return $this->phone;
    }

    /**
     * Setter last name
     *
     * @param string $last_name
     *
     * @return Croudinvesting
     */
    public function setLastName($last_name): Croudinvesting
    {
        $this->last_name = $last_name;

        return $this;
    }

    /**
     * Getter last name
     *
     * @return string
     */
    public function getLastName()
    {
        return $this->last_name;
    }

    /**
     * Getter plan to invest
     *
     * @return float
     */
    public function getPlanToInvest(): float
    {
        if (!isset($this->plan_to_invest) || empty($this->plan_to_invest)) {
            return 0;
        }
        return $this->plan_to_invest;
    }

    /**
     * Setter plan to invest
     *
     * @param float $plan_to_invest
     *
     * @return Croudinvesting
     */
    public function setPlanToInvest(float $plan_to_invest): Croudinvesting
    {
        $this->plan_to_invest = $plan_to_invest;

        return $this;
    }

    /**
     * Getter get additional info
     *
     * @return boolean
     */
    public function getAdditionalInfo(): boolean
    {
        if (!isset($this->additional_info) || empty($this->additional_info)) {
            return false;
        }
        return $this->additional_info;
    }

    /**
     * Setter get additional info
     *
     * @param boolean $additional_info
     *
     * @return Croudinvesting
     */
    public function setAdditionalInfo(boolean $additional_info): Croudinvesting
    {
        $this->additional_info = $additional_info;

        return $this;
    }

    /**
     * @return \DateTime
     * @throws \Exception
     */
    public function getPublished(): \DateTime
    {
        if (!isset($this->published) || empty($this->published)) {
            return new DateTime('now');
        }
        return $this->published;
    }

    /**
     * @param $published
     *
     * @return Croudinvesting
     */
    public function setPublished($published): Croudinvesting
    {
        if (!is_a($published, 'DateTime')) {
            $published = date_create($published);
        }
        $this->published = $published;

        return $this;
    }

    /**
     * @return \DateTime
     * @throws \Exception
     */
    public function getCreated(): \DateTime
    {
        if (!isset($this->published) || empty($this->published)) {
            return new DateTime('now');
        }
        return $this->created;
    }

    /**
     * @param $created
     *
     * @return Croudinvesting
     */
    public function setCreated($created): Croudinvesting
    {
        if (!is_a($created, 'DateTime')) {
            $created = date_create($created);
        }
        $this->created = $created;

        return $this;
    }

    /**
     * @return \DateTime
     * @throws \Exception
     */
    public function getUpdated(): \DateTime
    {
        if (!isset($this->updated) || empty($this->updated)) {
            return new DateTime('now');
        }
        return $this->updated;
    }

    /**
     * @param $updated
     *
     * @return Croudinvesting
     */
    public function setUpdated($updated): Croudinvesting
    {
        if (!is_a($updated, 'DateTime')) {
            $updated = date_create($updated);
        }
        $this->updated = $updated;

        return $this;
    }

    /**
     * Set status
     *
     * @param integer $status
     *
     * @return Croudinvesting
     */
    public function setStatus($status): Croudinvesting
    {
        $this->status = $status;

        return $this;
    }

    /**
     * Get status
     *
     * @return integer
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     *
     * @ORM\PreUpdate
     * @ORM\PostPersist
     */
    public function clearCache()
    {
        $app = app();
        if (!$app) {
            return;
        }
        $cache = $app->getService('cache');
        if (!$cache) {
            return;
        }
        $cache->delete('croudinvesting.' . $this->id);
    }

    public function getData($params=[])
    {
        return array_merge([
            'id' => $this->id,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name,
            'phone' => $this->phone,
            'email' => $this->email,
            'plan_to_invest' => $this->plan_to_invest,
            'additional_info' => $this->additional_info,
            'template' => str_replace('\\', '.', get_called_class()),
        ], $params);
    }

    public function getFullName()
    {
        return trim($this->first_name . ' ' . $this->last_name);
    }

    public static function prepare($croudinvestings)
    {
        foreach ($croudinvestings as $croudinvesting) {
            $croudinvesting->init = true;
        }
    }
}