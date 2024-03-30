<?php

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\ProductController;
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
    Route::get('/AllCategory',[CategoryController::class,'AllCategory']);
    Route::get('/AllRequest',[CategoryController::class,'AllRequest']);

});

Route::group(['prefix'=>'/product'],function(){
    Route::get('/GetProducts/{id}',[ProductController::class,'GetProducts']);
    Route::get('/IsCodeFabricantExist/{code}',[ProductController::class,'IsCodeFabricantExist']);
});

Route::group(['prefix'=>'/auth'],function(){
    Route::post('/register',[AuthController::class,'Register']);
    Route::post('/login',[AuthController::class,'Login']);
    Route::get('/sendToken/{email}',[AuthController::class,'EnvoyerToken']);
    Route::post('/VerifyEmail',[AuthController::class,'VerifyEmail']);
    Route::post('/ForgotPassword/{email}',[AuthController::class,'ForgotPassword']);
    Route::post('/ChangerPassword',[AuthController::class,'ChangerPassword']);
});

Route::middleware("auth:sanctum")->group(function(){

    Route::group(['prefix'=>'/product'],function(){
        Route::post('/AddProduct',[ProductController::class,'AddProduct']);
        Route::delete('/DeleteProduct/{id}',[ProductController::class,'DeleteProduct']);
        Route::post('/UpdateProduct/{id}',[ProductController::class,'UpdateProduct']);
        Route::put('/AcceptProduct/{id}',[ProductController::class,'AcceptProduct']);
        Route::put('/RejectProduct/{id}',[ProductController::class,'RejectProduct']);
        Route::get('/ListProduct/{id}',[ProductController::class,'ListProduct']);
    });

    Route::group(['prefix'=>'/category'],function(){
        Route::post('/AddCategory',[CategoryController::class,'AddCategory']);
        Route::delete('/DeleteCategory/{id}',[CategoryController::class,'DeleteCategory']);
        Route::get('/EditCategory/{id}',[CategoryController::class,'EditCategory']);
        Route::post('/UpdateCategory/{id}',[CategoryController::class,'UpdateCategory']);
        Route::put('/AcceptCategory/{id}',[CategoryController::class,'AcceptCategory']);
        Route::put('/RejectCategory/{id}',[CategoryController::class,'RejectCategory']);
        Route::get('/ListCategory',[CategoryController::class,'ListCategory']);
    });

});
