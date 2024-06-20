<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Symfony\Component\HttpKernel\Exception\HttpException;
use App\Models\Jewel;
use OpenApi\Annotations as OA;

/**
 * Class Jewel.
 *
 * @type JamesWL <james.422023009@civitas.ukrida.ac.id>
*/
class JewelController extends Controller
{
    /**
     * @OA\Get(
     *     path="/api/jewel",
     *     tags={"Jewel"},
     *     summary="Display a listing of items",
     *     operationId="index",
     *     @OA\Response(
     *         response=200,
     *         description="successful",
     *         @OA\JsonContent()
     *     ),
     *     @OA\Parameter(
     *         name="_page",
     *         in="query",
     *         description="current page",
     *         required=true,
     *         @OA\Schema(
     *             type="integer",
     *             format="int64",
     *             example=1
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="_limit",
     *         in="query",
     *         description="max item in a page",
     *         required=true,
     *         @OA\Schema(
     *             type="integer",
     *             format="int64",
     *             example=10
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="_search",
     *         in="query",
     *         description="word to search",
     *         required=false,
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="_type",
     *         in="query",
     *         description="search by type like ruby, diamond, etc",
     *         required=false,
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="_price",
     *         in="query",
     *         description="search by price like under $1k, $1-5k, etc",
     *         required=false,
     *         @OA\Schema(
     *             type="integer",
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="_sort_by",
     *         in="query",
     *         description="word to search",
     *         required=false,
     *         @OA\Schema(
     *             type="string",
     *             example="latest"
     *         )
     *     ),
     * )
     */
    public function index(Request $request)
    {
        try {
            $data['filter']       = $request->all();
            $page                 = $data['filter']['_page']  = (@$data['filter']['_page'] ? intval($data['filter']['_page']) : 1);
            $limit                = $data['filter']['_limit'] = (@$data['filter']['_limit'] ? intval($data['filter']['_limit']) : 1000);
            $offset               = ($page?($page-1)*$limit:0);
            $data['products']     = Jewel::whereRaw('1 = 1');
            
            if($request->get('_search')){
                $data['products'] = $data['products']->whereRaw('(LOWER(name) LIKE "%'.strtolower($request->get('_search')).'%")');
            }
            if($request->get('_type')){
                $data['products'] = $data['products']->whereRaw('LOWER(type) = "'.strtolower($request->get('_type')).'"');
            }
            if ($request->has('_price')) {
                $priceRange = $request->input('_price');
                switch ($priceRange) {
                    case 'under_1k':
                    $data['products'] = $data['products']->where('price', '<', 1000);
                    break;
                    case '1_5k':
                    $data['products'] = $data['products']->whereBetween('price', [1000, 5000]);
                    break;
                    case '5_10k':
                    $data['products'] = $data['products']->whereBetween('price', [5000, 10000]);
                    break;
                    case 'above_10k':
                    $data['products'] = $data['products']->where('price', '>', 10000);
                    break;
                    default:
                    break;
                }
            }
            if($request->get('_sort_by')){
                switch ($request->get('_sort_by')) {
                    default:
                    case 'latest_added':
                    $data['products'] = $data['products']->orderBy('created_at','DESC');
                    break;
                    case 'name_asc':
                    $data['products'] = $data['products']->orderBy('name','ASC');
                    break;
                    case 'name_desc':
                    $data['products'] = $data['products']->orderBy('name','DESC');
                    break;
                    case 'price_asc':
                    $data['products'] = $data['products']->orderBy('price','ASC');
                    break;
                    case 'price_desc':
                    $data['products'] = $data['products']->orderBy('price','DESC');
                    break;
                }
            }
            $data['products_count_total']   = $data['products']->count();
            $data['products']               = ($limit==0 && $offset==0)?$data['products']:$data['products']->limit($limit)->offset($offset);
            // $data['products_raw_sql']       = $data['products']->toSql();
            $data['products']               = $data['products']->get();
            $data['products_count_start']   = ($data['products_count_total'] == 0 ? 0 : (($page-1)*$limit)+1);
            $data['products_count_end']     = ($data['products_count_total'] == 0 ? 0 : (($page-1)*$limit)+sizeof($data['products']));
           return response()->json($data, 200);

        } catch(\Exception $exception) {
            throw new HttpException(400, "Invalid data : {$exception->getMessage()}");
        }
    }

    /**
     * @OA\Post(
     *     path="/api/jewel",
     *     tags={"Jewel"},
     *     summary="Store a newly created item",
     *     operationId="store",
     *     @OA\Response(
     *         response=400,
     *         description="Invalid input",
     *         @OA\JsonContent()
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Successful",
     *         @OA\JsonContent()
     *     ),
     *     @OA\RequestBody(
     *         required=true,
     *         description="Request body description",
     *         @OA\JsonContent(
     *             ref="#/components/schemas/Jewel",
     *             example={"name": "Kalung Berlian Elegan",
     *                      "type": "Diamond",
     *                      "carat": "5",
     *                      "price": "15000",
     *                      "description": "Kalung berlian indah dengan liontin berbentuk hati, terbuat dari emas putih 18 karat dan berlian berkilauan.",
     *                      "image": "https://images.tokopedia.net/img/cache/900/hDjmkQ/2024/4/7/6328cc0b-3846-46b7-b8ef-1d0e8dcb0353.jpg"
     *                     }
     *         ),
     *     ),
     *     security={{"passport_token_ready":{},"passport":{}}}
     * )
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'name' => 'required',
                'type' => 'required',
            ]);
            if ($validator->fails()) {
                throw new HttpException(400, $validator->messages()->first());
            }
            $jewels = new Jewel;
            $jewels->fill($request->all())->save();
            return $jewels;

        } catch(\Exception $exception) {
            throw new HttpException(400, "Invalid data - {$exception->getMessage}");
        }   
    }

    /**
     * @OA\Get(
     *     path="/api/jewel/{id}",
     *     tags={"Jewel"},
     *     summary="Display the specified item",
     *     operationId="show",
     *     @OA\Response(
     *         response=404,
     *         description="Item not found",
     *         @OA\JsonContent()
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Invalid input",
     *         @OA\JsonContent()
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful",
     *         @OA\JsonContent()
     *     ),
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         description="ID of item that needs to be displayed",
     *         required=true,
     *         @OA\Schema(
     *             type="integer",
     *             format="int65"
     *         )
     *     ),
     * )
     */
    public function show(string $id)
    {
        $jewels = Jewel::find($id);
        if(!$jewels){
            throw new HttpException(400, 'Item not found');
        }
        return $jewels;
    }
    
    /**
     * @OA\Put(
     *      path="/api/jewel/{id}",
     *      tags={"Jewel"},
     *      summary="Update the specified item",
     *      operationId="update",
     *      @OA\Response(
     *          response=404,
     *          description="Item not found",
     *          @OA\JsonContent()
     *      ),
     *      @OA\Response(
     *          response=400,
     *          description="Invalid input",
     *          @OA\JsonContent()
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="Successful",
     *          @OA\JsonContent()
     *      ),
     *      @OA\Parameter(
     *          name="id",
     *          in="path",
     *          description="ID of item that needs to be updated",
     *          required=true,
     *          @OA\Schema(
     *              type="integer",
     *              format="int64"
     *          )
     *      ),
     *      @OA\RequestBody(
     *          required=true,
     *          description="Request body description",
     *          @OA\JsonContent(
     *              ref="#/components/schemas/Jewel",
     *              example={"name": "Cincin Ruby Klasik",
     *                       "type": "Ruby",
     *                       "carat": "2",
     *                       "price": "8000",
     *                       "description": "Cincin ruby klasik dengan batu ruby merah yang menawan, dikelilingi oleh berlian kecil yang berkilauan.",
     *                       "image": "https://media.istockphoto.com/id/815613222/id/foto/cincin-emas.jpg?s=612x612&w=0&k=20&c=BXgN2blpaxcH0b7U21JgeglhImoO1y5Ohd1XiWQmD_U=",
     *                      }
     *          ),
     *      ),
     *     security={{"passport_token_ready":{},"passport":{}}}
     * )
     */
    public function update(Request $request, string $id)
    {
        $jewels = Jewel::find($id);
        if(!$jewels) {
            throw new HttpException (404, 'Item not found');
        }

        try {
            $validator = Validator:: make($request->all(), [
                'name' => 'required',
                'type' => 'required',
            ]);
            if ($validator->fails()) {
                throw new HttpException (400, $validator->messages()->first());
            }
            $jewels->fill($request->all())->save();
            return response()->json(array('message' => 'Updated successfully'), 200);

        } catch(\Exception $exception) {
            throw new HttpException(400, "Invalid data: {$exception->getMessage()}");
        }
    }

    /**
     * @OA\Delete(
     *      path="/api/jewel/{id}",
     *      tags={"Jewel"},
     *      summary="Remove the specified item",
     *      operationId="destroy",
     *      @OA\Response(
     *          response=404,
     *          description="Item not found",
     *          @OA\JsonContent()
     *      ),
     *      @OA\Response(
     *          response=400,
     *          description="Invalid input",
     *          @OA\JsonContent()
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="Successful",
     *          @OA\JsonContent()
     *      ),
     *      @OA\Parameter(
     *          name="id",
     *          in="path",
     *          description="ID of item that needs to be removed",
     *          required=true,
     *          @OA\Schema(
     *              type="integer",
     *              format="int64"
     *          )
     *      ),
     *     security={{"passport_token_ready":{},"passport":{}}}
     * )
     */
    public function destroy(string $id)
    {
        $jewels = Jewel::find($id);
        if(!$jewels) {
            throw new HttpException (404, 'Item not found');
        }
    
        try {
            $jewels->delete();
            return response()->json(array('message' => 'Deleted successfully'), 200);

        } catch(\Exception $exception) {
            throw new HttpException (400, "Invalid data: ($exception->getMessage()}");
        }
    }
}
