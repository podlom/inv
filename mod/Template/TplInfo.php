<?php

namespace Template;

/**
 * 
 */
class TplInfo implements \JsonSerializable
{

	protected $name;
	protected $path;
	protected $mtime;

	public function getName()
	{
		return $this->name;
	}

	public function getPath()
	{
		return $this->path;
	}

	public function getMtime()
	{
		return $this->mtime;
	}
	
	public function __construct(array $values)
	{
		$this->name = $values['name'];
		$this->path = $values['path'];
		$this->mtime = $values['mtime'];
	}

	public function toArray()
	{
		return [
			'name'=>$this->getName(),
			'path'=>$this->getPath(),
			'mtime'=>$this->getMtime(),
		];
	}

	public function jsonSerialize()
	{
		return $this->toArray();
	}

	public function __toString()
	{
		return 'TplInfo('.$this->getName().')';
	}

}