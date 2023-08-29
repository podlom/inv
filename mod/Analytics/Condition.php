<?php

namespace Analytics;

class Condition  implements iCondition{
    
    const MODE_NOT = 16; // inverse result (if not)
    const MODE_EQ = 0; // =
    const MODE_GT = 1; // >
    const MODE_LT = 2; // <
    
    const MODE_LIKE = 3; //strpos !== false
    const MODE_PREG = 4; //preg_match
    
    protected $name;
    protected $mode;
    protected $pattern;
    
    public function __construct($name, $pattern, $match_mode=0){
            $this->name = $name;
            $this->pattern = $pattern;
            $this->mode = $match_mode;
    }
    
    public function match($data){
        $value = isset($data[$name])?$data[$name]:null;
        $result = (bool)($this->mode & self::MODE_NOT);
        switch($this->mode){
            case self::MODE_EQ;
                return (bool)(($value == $this->pattern)^$result);
            break;
            case self::MODE_GT;
                return (bool)(($value > $this->pattern)^$result);
            break;
            case self::MODE_LT;
                return (bool)(($value < $this->pattern)^$result);
            break;
            case self::MODE_LIKE;
                return (bool)((mb_strpos($value,$this->pattern)!==false)^$result);
            break;
            case self::MODE_PREG;
                return (bool)(preg_match($this->pattern,$value)^$result);
            break;
            default:
                return true;
            break;
        }
    }
    
}
