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
 * @author JamesWL <james.422023009@civitas.ukrida.ac.id>
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
     *     )
     * )
     */
    public function index()
    {
        return Jewel::get();
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
