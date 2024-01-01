<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function Register(Request $request ){

        User::Create([
            'nom'=>$request->nom,
            'prenom'=>$request->prenom,
            'email'=>$request->email,
            'password'=>bcrypt($request->password),
            'photo'=>$request->photo,
            'Isadmin'=>false,
        ]);
        return response()->json(['data'=>"user created"],200);
    }

    public function Login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            
            $token = $user->createToken('api_token')->plainTextToken;
            $respnose = [
                "id"=>$user->id,
                'token' => $token,
                'email' => $user->email,
                "password" => $user->password, 
                'nom' => $user->nom,
                'prenom' => $user->prenom,
                'isAdmin' => $user->Isadmin,
                "photo" => $user->photo,
            ];
            
            return response()->json($respnose, 200);
        } else {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }
    }
}
