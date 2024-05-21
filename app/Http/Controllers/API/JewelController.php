<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Symfony\Component\HttpKernel\Exception\HttpException;
use App\Models\Jewel;

class JewelController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Jewel::get();
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        // return view ('jewel.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $jewels = new Jewel;
            $jewels->fill($request->validated())->save();

            return $jewels;
        } catch(\Exception $exception) {
            throw new HttpException(400, "Invalid data - {$exception->getMessage}");
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $jewels = Jewel::findOrFail($id);
        return $jewels;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        if (!$id) {
            throw new HttpException (400, "Invalid id");
        }

        try {
            $jewels = Jewel:: find($id);
            $jewels->fill($request->validated())->save();

            return $jewels;

        } catch(\Exception $exception) {
            throw new HttpException (400, "Invalid data {$exception->getMessage}");
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $jewels = Jewel:: findorfail($id);
        $jewels->delete();
        
        return response()->json(null, 204);
    }
}
