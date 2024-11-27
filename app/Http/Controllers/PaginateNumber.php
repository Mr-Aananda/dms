<?php
namespace App\Http\Controllers;

trait PaginateNumber {
    /**
     * @return int
     */
    protected function paginateNumber(): int
    {
        return 25;
    }
}
