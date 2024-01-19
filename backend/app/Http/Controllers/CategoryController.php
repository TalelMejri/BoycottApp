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
        if($request->user()->Isadmin){
            $categorie->status=1;
        }
        $categorie->save();
        return response()->json([
            'message'=>'Category Added Successfully',
        ],201);
    }

    public function AllCategory(){
        $categories = Categorie::withCount("products")->where("status",1)->get();
        return response()->json([
            'categories'=>$categories,
        ],200);
    }

    public function ListCategory(){
        $categories = Categorie::where("status",0)->get();
        return response()->json([
            'categories'=>$categories,
        ],200);
    }

    public function AcceptCategory($id){
        $category=Categorie::find($id);
        $category->update([
            'status'=> 1
        ]);
        return response()->json(["message"=>"Categpry Accpeted"]);
    }

    public function RejectCategory($id){
        $category=Categorie::find($id);
        $category->update([
            'status'=> 2
        ]);
        return response()->json(["message"=>"Categpry Rejected"]);
    }

    public function DeleteCategory($id){
        $category=Categorie::find($id);
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
        $category=Categorie::find($id);
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
        $category=Categorie::find($id);
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
