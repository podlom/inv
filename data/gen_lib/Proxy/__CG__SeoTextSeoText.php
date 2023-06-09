<?php

namespace Proxy\__CG__\SeoText;

/**
 * DO NOT EDIT THIS FILE - IT WAS CREATED BY DOCTRINE'S PROXY GENERATOR
 */
class SeoText extends \SeoText\SeoText implements \Doctrine\ORM\Proxy\Proxy
{
    /**
     * @var \Closure the callback responsible for loading properties in the proxy object. This callback is called with
     *      three parameters, being respectively the proxy object to be initialized, the method that triggered the
     *      initialization process and an array of ordered parameters that were passed to that method.
     *
     * @see \Doctrine\Common\Persistence\Proxy::__setInitializer
     */
    public $__initializer__;

    /**
     * @var \Closure the callback responsible of loading properties that need to be copied in the cloned object
     *
     * @see \Doctrine\Common\Persistence\Proxy::__setCloner
     */
    public $__cloner__;

    /**
     * @var boolean flag indicating if this object was already initialized
     *
     * @see \Doctrine\Common\Persistence\Proxy::__isInitialized
     */
    public $__isInitialized__ = false;

    /**
     * @var array properties to be lazy loaded, with keys being the property
     *            names and values being their default values
     *
     * @see \Doctrine\Common\Persistence\Proxy::__getLazyProperties
     */
    public static $lazyPropertiesDefaults = [];



    /**
     * @param \Closure $initializer
     * @param \Closure $cloner
     */
    public function __construct($initializer = null, $cloner = null)
    {

        $this->__initializer__ = $initializer;
        $this->__cloner__      = $cloner;
    }







    /**
     * 
     * @return array
     */
    public function __sleep()
    {
        if ($this->__isInitialized__) {
            return ['__isInitialized__', 'id', 'uri', 'text', 'added_at', 'updated_at'];
        }

        return ['__isInitialized__', 'id', 'uri', 'text', 'added_at', 'updated_at'];
    }

    /**
     * 
     */
    public function __wakeup()
    {
        if ( ! $this->__isInitialized__) {
            $this->__initializer__ = function (SeoText $proxy) {
                $proxy->__setInitializer(null);
                $proxy->__setCloner(null);

                $existingProperties = get_object_vars($proxy);

                foreach ($proxy->__getLazyProperties() as $property => $defaultValue) {
                    if ( ! array_key_exists($property, $existingProperties)) {
                        $proxy->$property = $defaultValue;
                    }
                }
            };

        }
    }

    /**
     * 
     */
    public function __clone()
    {
        $this->__cloner__ && $this->__cloner__->__invoke($this, '__clone', []);
    }

    /**
     * Forces initialization of the proxy
     */
    public function __load()
    {
        $this->__initializer__ && $this->__initializer__->__invoke($this, '__load', []);
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __isInitialized()
    {
        return $this->__isInitialized__;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __setInitialized($initialized)
    {
        $this->__isInitialized__ = $initialized;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __setInitializer(\Closure $initializer = null)
    {
        $this->__initializer__ = $initializer;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __getInitializer()
    {
        return $this->__initializer__;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     */
    public function __setCloner(\Closure $cloner = null)
    {
        $this->__cloner__ = $cloner;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific cloning logic
     */
    public function __getCloner()
    {
        return $this->__cloner__;
    }

    /**
     * {@inheritDoc}
     * @internal generated method: use only when explicitly handling proxy specific loading logic
     * @static
     */
    public function __getLazyProperties()
    {
        return self::$lazyPropertiesDefaults;
    }

    
    /**
     * {@inheritDoc}
     */
    public function getId()
    {
        if ($this->__isInitialized__ === false) {
            return (int)  parent::getId();
        }


        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getId', []);

        return parent::getId();
    }

    /**
     * {@inheritDoc}
     */
    public function getUri(): string
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getUri', []);

        return parent::getUri();
    }

    /**
     * {@inheritDoc}
     */
    public function setUri(string $uri): \SeoText\SeoText
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setUri', [$uri]);

        return parent::setUri($uri);
    }

    /**
     * {@inheritDoc}
     */
    public function getText(): string
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getText', []);

        return parent::getText();
    }

    /**
     * {@inheritDoc}
     */
    public function setText(string $text): \SeoText\SeoText
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setText', [$text]);

        return parent::setText($text);
    }

    /**
     * {@inheritDoc}
     */
    public function getAddedAt()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getAddedAt', []);

        return parent::getAddedAt();
    }

    /**
     * {@inheritDoc}
     */
    public function setAddedAt($added_at): \SeoText\SeoText
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setAddedAt', [$added_at]);

        return parent::setAddedAt($added_at);
    }

    /**
     * {@inheritDoc}
     */
    public function getUpdatedAt(): \DateTime
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getUpdatedAt', []);

        return parent::getUpdatedAt();
    }

    /**
     * {@inheritDoc}
     */
    public function setUpdatedAt($updated_at): \SeoText\SeoText
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'setUpdatedAt', [$updated_at]);

        return parent::setUpdatedAt($updated_at);
    }

    /**
     * {@inheritDoc}
     */
    public function clearCache()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'clearCache', []);

        return parent::clearCache();
    }

    /**
     * {@inheritDoc}
     */
    public function getData($params = array (
))
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'getData', [$params]);

        return parent::getData($params);
    }

    /**
     * {@inheritDoc}
     */
    public function save($flush = false)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'save', [$flush]);

        return parent::save($flush);
    }

    /**
     * {@inheritDoc}
     */
    public function delete($flush = false)
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, 'delete', [$flush]);

        return parent::delete($flush);
    }

    /**
     * {@inheritDoc}
     */
    public function __toString()
    {

        $this->__initializer__ && $this->__initializer__->__invoke($this, '__toString', []);

        return parent::__toString();
    }

}
