<?php

namespace App\Http\Controllers;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function GetProducts($id)
    {
        $products = Product::where('id_categorie',$id)->get();
        return response()->json([
            'products' => $products
        ], 200);
    }

    public function AddProduct(Request $request)
    {
        $product = new Product();
        $product->name = $request->name;
        $product->photo = $request->photo;
        $product->description = $request->description;
        $product->id_categorie = $request->id_categorie;
        $product->save();

        return response()->json([
            'message' => 'Product added successfully',
        ], 201);

    }

    public function UpdateProduct(Request $request, $id)
    {
        $product = Product::find($id);
        $product->name = $request->name;
        $product->photo = $request->photo;
        $product->description = $request->description;
        $product->id_categorie = $request->id_categorie;
        $product->save();

        return response()->json([
            'message' => 'Product updated successfully',
        ], 200);
    }

    public function DeleteProduct($id)
    {
        $product = Product::find($id);
        $product->delete();

        return response()->json([
            'message' => 'Product deleted successfully'
        ], 200);
    }

}
