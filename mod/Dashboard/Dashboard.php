<?php

namespace Dashboard;


use Doctrine\ORM\Mapping as ORM;
use Skynar\Annotation\Sync;


/**
 * @ORM\Entity
 * @ORM\Table(name="Dashboard")
 * @ORM\HasLifecycleCallbacks
 * @ORM\InheritanceType("SINGLE_TABLE")
 * @ORM\DiscriminatorColumn(name="class", type="smallint")
 */
abstract class Dashboard extends \Skynar\BaseModel
{
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
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=255)
     */
    protected $name;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="text", length=5000)
     */
    protected $description;

    /**
     * @var integer
     *
     * @ORM\Column(type="integer")
     */
    protected $status = 1;

    /**
     * @var array
     *
     * @Sync\Input
     * @ORM\Column(type="json_array")
     */
    protected $options = [];

    /**
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
     * Set name
     *
     * @param string $name
     *
     * @return Dashboard
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set description
     *
     * @param string $description
     *
     * @return Dashboard
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Get description
     *
     * @return string
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set status
     *
     * @param integer $status
     *
     * @return Dashboard
     */
    public function setStatus($status)
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
     * Set options
     *
     * @param array $options
     *
     * @return Dashboard
     */
    public function setOptions($options)
    {
        $this->options = $options;

        return $this;
    }

    /**
     * Get options
     *
     * @return array
     */
    public function getOptions()
    {
        return $this->options;
    }

    /**
     * Get option
     *
     * @param string $name
     * @param mixed $default optional
     *
     * @return mixed
     */
    public function getOption($name, $default = null)
    {
        return isset($this->options[$name]) ? $this->options[$name] : $default;
    }

    /**
     * Set option
     *
     * @param string $name
     * @param mixed $value
     *
     * @return Dashboard
     */
    public function setOption($name, $value)
    {
        $this->options[$name] = $value;
        return $this;
    }

    /**
     *
     * @ORM\PreUpdate
     * @ORM\PostPersist
     */
    public function clearCache()
    {
        $app = app();
        if(!$app)
            return;
        $cache = $app->getService('cache');
        if(!$cache)
            return;
        $cache->delete('dashboard.' . $this->id);
    }


    public function getData($params=[])
    {
        return array_merge([
            'id' => $this->id,
            'name' => $this->name,
            'description' => $this->description,
            'template' => str_replace('\\', '.', get_called_class()),
        ], $params);
    }

    public static function prepare($dashboards)
    {
        foreach ($dashboards as $dashboard) {
            $dashboard->init = true;
        }
    }

    /* public function getAssets()
    {
        return [new \Skynar\Assets\Style('/assets/Poll/style.css'), 'ui'];
    } */
}