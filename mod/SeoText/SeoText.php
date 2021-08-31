<?php

namespace SeoText;


use Doctrine\ORM\Mapping as ORM;
use Skynar\Annotation\Sync;
use Skynar\Exception\InvalidArgument;


/**
 * SeoText model
 * @ORM\Entity
 * @ORM\Table(name="seo_block")
 */
class SeoText extends \Skynar\BaseModel
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
    protected $uri;

    /**
     * @var string
     *
     * @Sync\Input
     * @ORM\Column(type="text", length=5000)
     */
    protected $text;

    /**
     * @var DateTime
     *
     * @Sync\Input
     * @ORM\Column(name="added_at", type="datetime" )
     */
    protected $added_at;

    /**
     * @var DateTime
     *
     * @Sync\Input
     * @ORM\Column(name="updated_at", type="datetime" )
     */
    protected $updated_at;

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
     * Get URI
     *
     * @return string
     */
    public function getUri(): string
    {
        if (!isset($this->uri) || empty($this->uri)) {
            return '';
        }
        return $this->uri;
    }

    /**
     * @param string $uri
     *
     * @return SeoText
     */
    public function setUri(string $uri): SeoText
    {
        $this->uri = $uri;

        return $this;
    }

    /**
     * Get text
     *
     * @return string
     */
    public function getText(): string
    {
        if (!isset($this->text) || empty($this->text)) {
            return '';
        }
        return $this->text;
    }

    /**
     * @param string $text
     *
     * @return SeoText
     */
    public function setText(string $text): SeoText
    {
        $this->text = $text;

        return $this;
    }

    /**
     * Get added_at
     *
     * @return string
     */
    public function getAddedAt()
    {
        return $this->added_at;
    }

    /**
     * Set added_at
     *
     * @param string $added_at
     *
     * @return SeoText
     */
    public function setAddedAt($added_at): SeoText
    {
        $this->added_at = $added_at;

        return $this;
    }

    /**
     * Get updated_at
     *
     * @return \DateTime
     * @throws \Exception
     */
    public function getUpdatedAt(): \DateTime
    {
        if (!isset($this->updated_at) || empty($this->updated_at)) {
            return new \DateTime('now');
        }
        return $this->updated_at;
    }

    /**
     * Set updated_at
     *
     * @param string $updated_at
     *
     * @return SeoText
     */
    public function setUpdatedAt($updated_at): SeoText
    {
        $this->updated_at = $updated_at;

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
        if (!$app) {
            return;
        }
        $cache = $app->getService('cache');
        if (!$cache) {
            return;
        }
        $cache->delete('seotext.' . $this->id);
    }

    public function getData($params=[])
    {
        return array_merge([
            'id' => $this->id,
            'uri' => $this->uri,
            'text' => $this->text,
            'added_at' => $this->added_at,
            'updated_at' => $this->updated_at,
            'template' => str_replace('\\', '.', get_called_class()),
        ], $params);
    }
}