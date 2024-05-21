<?php

namespace App\Models;

// use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\User;
use OpenApi\Annotations as OA;

/** 
 * Class Jewel.
 * 
 * @author JamesWL <james.422023009@civitas.ukrida.ac.id>
 * 
 * @OA\Schema(
 *     description="Jewel model",
 *     title="Jewel model",
 *     required={"name", "type"},
 *     @OA\Xml(
 *         name="Jewel"
 *     )
 * )
 */
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
