<?php

namespace App\Http\Controllers;

use App\Http\Requests\CategoryRequest;
use App\Mail\Accept_Reject_Item;
use Illuminate\Http\Request;
use App\Models\Categorie;
use App\Models\User;
use Illuminate\Support\Facades\Mail;

class CategoryController extends Controller
{

    public function AddCategory(CategoryRequest $request){
        $file_name = time() . '_' . $request->photo->getClientOriginalName();
        $image = $request->file('photo')->storeAs('images', $file_name, 'public');

        $categorie=new Categorie();
        $categorie->name=$request->name;
        $categorie->photo = '/storage/' . $image;
        $categorie->user_id=$request->user()->id;
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

    public function AllRequest(Request $request){
        $categories = Categorie::withCount("products")->where("status",$request->status)->get();
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
        $user=User::find($category->user_id);
        Mail::to($user->email)->send(new Accept_Reject_Item("Thanks For Your Suppor "+$user->nom+" "+"Your Category With Label "+$category->name +" Accepted"));
        return response()->json(["message"=>"Categpry Accpeted"]);
    }

    public function RejectCategory($id){
        $category=Categorie::find($id);
        // $category->update([
        //     'status'=> 2
        // ]);
        $user=User::find($category->user_id);
        Mail::to($user->email)->send(new Accept_Reject_Item($user->nom+" "+"Your Category With Label "+$category->name +" Rejected"));
        $category->delete();
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
            if($request->hasFile('photo')){
                $file_name = time() . '_' . $request->photo->getClientOriginalName();
                $image = $request->file('photo')->storeAs('images', $file_name, 'public');
                $category->photo = '/storage/' . $image;
            }
            $category->save();
            return response()->json([
                'message'=>'Category Updated Successfully',
            ],200);
        }
   }

}
