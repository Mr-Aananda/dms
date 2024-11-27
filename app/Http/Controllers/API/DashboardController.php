<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Services\Dashboard\DashboardService;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(DashboardService $service)
    {
        if (\request('is_almak')) {
            return $service->dashboardData();
        }
    }
}
