<?php

namespace App\Http\Controllers;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function GetProducts($id)
    {
        $products = Product::where("status",1)->where('categorie_id',$id)->get();
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
        $product->user_id = $request->user()->id;
        $product->categorie_id = $request->id_categorie;
        if($request->user()->Isadmin){
            $product->status=1;
        }
        $product->save();
        return response()->json([
            'message' => 'Product added successfully',
        ], 201);

    }

    public function ListProduct($id){
        $products = Product::where("status",0)->where('categorie_id',$id)->get();
        return response()->json([
            'products'=>$products,
        ],200);
    }

    public function AcceptProduct($id){
        $Product=Product::find($id);
        $Product->update([
            'status'=> 1
        ]);
        return response()->json(["message"=>"Product Accpeted"]);
    }

    public function RejectProduct($id){
        $Product=Product::find($id);
        $Product->update([
            'status'=> 2
        ]);
        $Product->delete();
        return response()->json(["message"=>"Product Rejected"]);
    }

    public function UpdateProduct(Request $request, $id)
    {
        $product = Product::find($id);
        $product->name = $request->name;
        $product->photo = $request->photo;
        $product->description = $request->description;
        $product->categorie_id = $request->id_categorie;
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
