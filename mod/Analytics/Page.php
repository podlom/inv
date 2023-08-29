<?php
namespace Analytics;

use Doctrine\ORM\Mapping as ORM;
use Skynar\Model\Timestamps;

/**
 * Link
 * @ORM\Entity
 */
class Page extends \Skynar\BaseModel{
    
    /**
     * @Orm\Id
     * @ORM\OneToOne(targetEntity="\Core\Page", inversedBy="analytics", cascade={"remove"})
     * @ORM\JoinColumn(name="page_id", referencedColumnName="id", onDelete="CASCADE")
     */
    protected $page;

    /**
     *
     * @ORM\Column(type="integer")
     * @Sphinx\Index
     */
    protected $views = 1;

    /**
     *
     * @ORM\Column(type="float", nullable=true)
     * @Sphinx\Index
     */
    protected $rating = 0;

    public function getPage(){
        return $this->page;
    }

    public function setPage(\Core\Page $page){
        $this->page = $page;
        return $this;
    }

    public function getViews(){
        return $this->views;
    }

    public function getRating(){
        return $this->rating;
    }

    public function setRating($rating){
        $this->rating = $rating;
    }
}
