<?php

namespace App\Models;

// use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\User;

class Jewel extends Model
{
    // use HasFactory;
    use SoftDeletes;
    protected $table='jewels';
    protected $fillable=[
        'name',
        'type',
        'carat',
        'price',
        'description',
        'image',
        'created_at',
        'created_by',
        'updated_at',
        'updated_by',
    ];
    
    public function data_adder(){
        return $this->belongsTo(User::class, 'created_by', 'id');
    }
}
