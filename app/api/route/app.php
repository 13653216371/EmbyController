<?php

namespace app\api\route;
use think\facade\Route;


Route::get('ping', 'api/index/ping');
Route::get('common/proxyImage', 'common/proxyImage');
Route::get('api/updateList/:appName', 'UpdateList/index');