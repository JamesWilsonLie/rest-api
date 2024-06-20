<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\JewelController;

Route::get('/', function () {
    return view('pages.home');
})->name('home');

Route::get('/cart', function () {
    return view('pages.cart');
})->name('cart');

Route::get('/jewel', function () {
    return view('pages.plp');
})->name('plp');

Route::get('/jewel/{i}', function () {
    return view('pages.pdp');
})->name('pdp');