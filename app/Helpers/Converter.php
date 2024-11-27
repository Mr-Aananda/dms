<?php

namespace App\Helpers;

class Converter
{
    /**
     * @param $data
     * @return array
     */
    public static function separator($data): array
    {
        return explode('/', $data);
    }

    /**
     * @param $quantity
     * @param $unit_label
     * @param $unit_relation
     */
    public static function convertToUpperUnit($quantity, $unit_label, $unit_relation)
    {
        // $relation = self::separator($unit_relation);
        // $labels = self::separator($unit_label);
        // $last = count($labels) - 1;
        // $recordWithCleanUnit = [];

        // for ($i = $last; $i >= 0; $i--) {
        //     $divisor = floatval($relation[$i]);
        //     $remainder = fmod($quantity, $divisor);
        //     $quantity = ($quantity) / ($divisor ? $divisor : 1);

        //     if ($i === 0) {
        //         if ($last > 0) {
        //             $recordWithCleanUnit[] = floor($quantity) . ' ' . $labels[$i];
        //         } else {
        //             $recordWithCleanUnit[] = $quantity . ' ' . $labels[$i];
        //         }
        //     } else {
        //         $remainder = number_format($remainder, 2);
        //         if ($remainder != 0) {
        //             $recordWithCleanUnit[] = $remainder . ' ' . $labels[$i];
        //         }
        //     }
        // }
        // $reverseUnit = array_reverse($recordWithCleanUnit);
        // return join(' ', $reverseUnit);

        $relations = self::separator($unit_relation);
        $labels = self::separator($unit_label);

        $recordWithCleanUnit = [];

        $last = count($labels) - 1;

        for ($i = $last; $i >= 0; $i--) {
            $divisor = floatval($relations[$i]);
            $remainder = fmod($quantity, $divisor);
            $quantity = ($quantity - $remainder) / ($divisor ? $divisor : 1);

            if ($i === 0) {
                $recordWithCleanUnit[] = $quantity . ' ' . $labels[$i];
            } else {
                $recordWithCleanUnit[] = $remainder . ' ' . $labels[$i];
            }
        }

        $reverseUnit = array_reverse($recordWithCleanUnit);
        return implode(' ', $reverseUnit);
    }
}
