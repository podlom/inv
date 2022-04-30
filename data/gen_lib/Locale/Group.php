<?php

namespace Locale;


use Doctrine\ORM\Mapping as ORM;


/**
 * Group
 *
 * @ORM\Table(name="LocaleGroup")
 * @ORM\Entity
 */
class Group extends \Locale\BaseGroup
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /**
     * @var \Core\Page
     *
     * @ORM\ManyToOne(targetEntity="Core\Page")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="ru", referencedColumnName="id", unique=true, nullable=true, onDelete="SET NULL")
     * })
     */
    protected $ru;

    /**
     * @var \Core\Page
     *
     * @ORM\ManyToOne(targetEntity="Core\Page")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="en", referencedColumnName="id", unique=true, nullable=true, onDelete="SET NULL")
     * })
     */
    protected $en;

    /**
     * @var \Core\Page
     *
     * @ORM\ManyToOne(targetEntity="Core\Page")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="pl", referencedColumnName="id", unique=true, nullable=true, onDelete="SET NULL")
     * })
     */
    protected $pl;

    /**
     * @var \Core\Page
     *
     * @ORM\ManyToOne(targetEntity="Core\Page")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="uk", referencedColumnName="id", unique=true, nullable=true, onDelete="SET NULL")
     * })
     */
    protected $uk;

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
     * Set ru.
     *
     * @param \Core\Page|null $ru
     *
     * @return Group
     */
    public function setRu(\Core\Page $ru = null)
    {
        $this->ru = $ru;

        return $this;
    }

    /**
     * Get ru.
     *
     * @return \Core\Page|null
     */
    public function getRu()
    {
        return $this->ru;
    }

    /**
     * Set en.
     *
     * @param \Core\Page|null $en
     *
     * @return Group
     */
    public function setEn(\Core\Page $en = null)
    {
        $this->en = $en;

        return $this;
    }

    /**
     * Get en.
     *
     * @return \Core\Page|null
     */
    public function getEn()
    {
        return $this->en;
    }

    /**
     * Set pl.
     *
     * @param \Core\Page|null $pl
     *
     * @return Group
     */
    public function setPl(\Core\Page $pl = null)
    {
        $this->pl = $pl;

        return $this;
    }

    /**
     * Get pl.
     *
     * @return \Core\Page|null
     */
    public function getPl()
    {
        return $this->pl;
    }

    /**
     * Set uk.
     *
     * @param \Core\Page|null $uk
     *
     * @return Group
     */
    public function setUk(\Core\Page $uk = null)
    {
        $this->uk = $uk;

        return $this;
    }

    /**
     * Get uk.
     *
     * @return \Core\Page|null
     */
    public function getUk()
    {
        return $this->uk;
    }
}
