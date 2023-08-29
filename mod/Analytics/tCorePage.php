<?php

namespace Analytics;

use Doctrine\ORM\Mapping as ORM;

trait tCorePage{
    
    /**
     * @ORM\OneToOne(targetEntity="\Analytics\Page", mappedBy="page", cascade={"remove"}, fetch="EAGER" )
     * @Sphinx\Index
     */
    protected $analytics;
    
    public function getAnalytics(){
        
        return $this->analytics;
        
    }
    
    public function getViews(){
        if($this->analytics)
            return $this->analytics->getViews();
        return 0;
    }
    
    public function getRating(){
        if($this->analytics)
            return $this->analytics->getRating();
        return 0;
    }
}
