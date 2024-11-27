<?php

namespace App\Helpers;

trait QuantityHelper
{
    /**
     * get division number of product quantity
     * @param $unit
     * @param $price_type
     * @return int|string
     */
    public static function getDivisorNumber($unit, $price_type)
    {
        $unitRelation = explode('/', $unit->relation);
        $divisor_number = 1;
        for ($i = 0; $i < count($unitRelation); $i++) {
            if ($i >= $price_type) {
                $divisor_number *= $unitRelation[$i + 1] ?? '1';
            }
        }

        return $divisor_number;
    }

    /**
     * get quantity for price type
     * @param $product
     * @param $productQuantity
     * @return float|int
     */
    public static function priceQuantity($product, $productQuantity)
    {
        $unitRelation = explode('/', $product->unit_relation);
        $quantity = 1;
        for ($i = 0; $i < count($unitRelation); $i++) {
            if ($i >= $product->price_type) {
                $quantity *= $unitRelation[$i + 1] ?? '1';
            }
        }
        return $productQuantity / $quantity;
    }
}
