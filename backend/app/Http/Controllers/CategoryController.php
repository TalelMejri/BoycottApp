<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Categorie;

class CategoryController extends Controller
{
    
    public function AddCategory(Request $request){
        $categorie=new Categorie();
        $categorie->name=$request->name;
        $categorie->photo=$request->photo;
        $categorie->save();
        return response()->json([
            'message'=>'Category Added Successfully',
        ],201);
    }

    public function AllCategory(){
        $categories=Category::all();
        return response()->json([
            'categories'=>$categories,
        ],200);
    }

    public function DeleteCategory($id){
        $category=Category::find($id);
        if(!$category){
            return response()->json([
                'message'=>'Category Not Found',
            ],404);
        }else{
            $category->delete();
            return response()->json([
                'message'=>'Category Deleted Successfully',
            ],200);
        }
    }

    public function EditCategory($id){
        $category=Category::find($id);
        if(!$category){
            return response()->json([
                'message'=>'Category Not Found',
            ],404);
        }else{
            return response()->json([
                'category'=>$category,
            ],200);
        }
    }

    public function UpdateCategory(Request $request,$id){
        $category=Category::find($id);
        if(!$category){
            return response()->json([
                'message'=>'Category Not Found',
            ],404);
        }else{
            $category->name=$request->name;
            $category->photo=$request->photo;
            $category->save();
            return response()->json([
                'message'=>'Category Updated Successfully',
            ],200);
        }
   }

}
