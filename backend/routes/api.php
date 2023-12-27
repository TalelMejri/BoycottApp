<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CategoryController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['prefix'=>'/category'],function(){
    Route::post('/AddCategory',[CategoryController::class,'AddCategory']);
    Route::get('/AllCategory',[CategoryController::class,'AllCategory']);
    Route::delete('/DeleteCategory/{id}',[CategoryController::class,'DeleteCategory']);
    Route::get('/EditCategory/{id}',[CategoryController::class,'EditCategory']);
    Route::put('/UpdateCategory/{id}',[CategoryController::class,'UpdateCategory']);
});
