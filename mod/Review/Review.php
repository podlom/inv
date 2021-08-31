<?php

namespace Review;


use Doctrine\ORM\Mapping as ORM;
use Skynar\Annotation\Sync;
use Skynar\Exception\InvalidArgument;


/**
 * Review model
 * @ORM\Entity
 * @ORM\Table(name="review")
 */
class Review extends \Skynar\BaseModel
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
     * @ORM\Column(type="string", length=255)
     */
    protected $image_url;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=255)
     */
    protected $category;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=32)
     */
    protected $first_name;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=32)
     */
    protected $last_name;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=64)
     */
    protected $company;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=64)
     */
    protected $job;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="text", length=5000)
     */
    protected $rtext;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=255)
     */
    protected $facebook_url;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="string", length=255)
     */
    protected $linkedin_url;

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
     * Get Image URL
     *
     * @return string
     */
    public function getImageUrl(): string
    {
        if (!isset($this->image_url) || empty($this->image_url)) {
            return '';
        }
        return $this->image_url;
    }

    /**
     * Get review category
     *
     * @return string
     */
    public function getCategory(): string
    {
        if (!isset($this->category) || empty($this->category)) {
            return '';
        }
        return $this->category;
    }

    /**
     * @param string $category
     *
     * @return Review
     */
    public function setCategory(string $category): Review
    {
        $this->category = $category;

        return $this;
    }

    /**
     * @param string $image_url
     *
     * @return Review
     */
    public function setImageUrl(string $image_url): Review
    {
        $this->image_url = $image_url;

        return $this;
    }

    /**
     * Set first name
     *
     * @param string $first_name
     *
     * @return Review
     */
    public function setFirstName($first_name): Review
    {
        $this->first_name = $first_name;

        return $this;
    }

    /**
     * Get first name
     *
     * @return string
     */
    public function getFirstName()
    {
        return $this->first_name;
    }

    /**
     * Set last name
     *
     * @param string $last_name
     *
     * @return Review
     */
    public function setLastName($last_name): Review
    {
        $this->last_name = $last_name;

        return $this;
    }

    /**
     * Get last name
     *
     * @return string
     */
    public function getLastName()
    {
        return $this->last_name;
    }

    /**
     * Get full (first + last) name
     *
     * @return string
     */
    public function getFullName()
    {
        return trim($this->first_name . ' ' . $this->last_name);
    }

    /**
     * @return string
     */
    public function getCompany(): string
    {
        if (!isset($this->company) || empty($this->company)) {
            return '';
        }
        return $this->company;
    }

    /**
     * @param string $company
     *
     * @return Review
     */
    public function setCompany(string $company): Review
    {
        $this->company = $company;

        return $this;
    }

    /**
     * @return string
     */
    public function getJob(): string
    {
        if (!isset($this->job) || empty($this->job)) {
            return '';
        }
        return $this->job;
    }

    /**
     * @param string $job
     *
     * @return Review
     */
    public function setJob(string $job): Review
    {
        $this->job = $job;

        return $this;
    }

    /**
     * Set rtext
     *
     * @param string $rtext
     *
     * @return Review
     */
    public function setRtext($rtext): Review
    {
        $this->rtext = $rtext;

        return $this;
    }

    /**
     * Get rtext
     *
     * @return string
     */
    public function getRtext()
    {
        return $this->rtext;
    }

    /**
     * @return string
     */
    public function getFacebookUrl(): string
    {
        if (!isset($this->facebook_url) || empty($this->facebook_url)) {
            return '';
        }
        return $this->facebook_url;
    }

    /**
     * @param string $facebook_url
     *
     * @return Review
     */
    public function setFacebookUrl(string $facebook_url): Review
    {
        $this->facebook_url = $facebook_url;

        return $this;
    }

    /**
     * @return string
     */
    public function getLinkedinUrl(): string
    {
        if (!isset($this->linkedin_url) || empty($this->linkedin_url)) {
            return '';
        }
        return $this->linkedin_url;
    }

    /**
     * @param string $linkedin_url
     *
     * @return Review
     */
    public function setLinkedinUrl(string $linkedin_url): Review
    {
        $this->linkedin_url = $linkedin_url;

        return $this;
    }

    /**
     * @return \DateTime
     * @throws \Exception
     */
    public function getPublished(): \DateTime
    {
        if (!isset($this->published) || empty($this->published)) {
            return new \DateTime('now');
        }
        return $this->published;
    }

    /**
     * @param $published
     *
     * @return Review
     */
    public function setPublished($published): Review
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
            return new \DateTime('now');
        }
        return $this->created;
    }

    /**
     * @param $created
     *
     * @return Review
     */
    public function setCreated($created): Review
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
            return new \DateTime('now');
        }
        return $this->updated;
    }

    /**
     * @param $updated
     *
     * @return Review
     */
    public function setUpdated($updated): Review
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
     * @return Review
     */
    public function setStatus($status): Review
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
        $cache->delete('review.' . $this->id);
    }

    public function getData($params=[])
    {
        return array_merge([
            'id' => $this->id,
            'image_url' => $this->image_url,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name,
            'company' => $this->company,
            'job' => $this->job,
            'facebook_url' => $this->facebook_url,
            'linkedin_url' => $this->linkedin_url,
            'rtext' => $this->rtext,
            'template' => str_replace('\\', '.', get_called_class()),
        ], $params);
    }

    public function getTitle()
    {
        return trim('#' . $this->id . ' ' . $this->first_name . ' ' . $this->last_name . ' ' . $this->job . ' в ' . $this->company);
    }

    public static function prepare($reviews)
    {
        foreach ($reviews as $review) {
            $review->init = true;
        }
    }
}