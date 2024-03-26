<?php

namespace App\Http\Controllers;

use App\Mail\SendTokenPassword;
use App\Mail\VerifyMail;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;

class AuthController extends Controller
{

    public function Register(Request $request ){
        User::Create([
            'nom'=>$request->nom,
            'prenom'=>$request->prenom,
            'email'=>$request->email,
            'password'=>bcrypt($request->password),
            'Isadmin'=>false,
        ]);
        $this->EnvoyerTokenEmail($request->email);
        return response()->json(['data'=>"user created"],200);
    }

    public function Login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            if (!$user->hasVerifiedEmail() ) {
                return response()->json(['data' => "votre email n'est pas vérifié"], 401);
            }
            $token = $user->createToken('api_token')->plainTextToken;
            $respnose = [
                "id"=>$user->id,
                'token' => $token,
                'email' => $user->email,
                "password" => $user->password,
                'nom' => $user->nom,
                'prenom' => $user->prenom,
                'isAdmin' => $user->Isadmin,
            ];

            return response()->json($respnose, 200);
        } else {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }
    }

    public function EnvoyerTokenEmail(String $email){
        $user=User::where('email',$email)->first();
        if($user){
            $token=mt_rand(10000,99999);
            if($user->email_token == null){
                $user->email_token=$token;
                $user->save();
                Mail::to($user->email)->send(new VerifyMail($user));
                return response()->json(['data'=>"Token has been sended"],200);
            }else{
                return response()->json(['data'=>"email already verified"],201);
            }
        }else{
            return response()->json(['data'=>"Email not found"],404);
        }
    }

    public function VerifyEmail(Request $request){
        $user=User::where('email',$request->email)->first();
        if($user){
            if($request->token == $user->email_token){
                $user->markEmailAsVerified();
                $user->email_verified_at=now();
                return response()->json(['data'=>"Email has been verified"],200);
            }else{
                return response()->json(['data'=>"Token invalid."],404);
            }
        }else{
            return response()->json(['data'=>"Email not found"],404);
        }
    }


    public function renvoyer(String $email){
        $user=User::where('email',$email)->first();
        if($user->hasVerifiedEmail()){
            return response()->json(['data'=>"email already verified"],200);
        }
        Mail::to($user->email)->send(new VerifyMail($user));
        return response()->json(['data'=>"Link verified send with success"],200);
    }


    public function ForgotPassword(String $email){
        $user=User::where('email',$email)->firstOrFail();
        $token=mt_rand(10000,99999);
        $user->password_token=$token;
        $user->password_token_send_at=now();
        $user->save();
        Mail::to($email)->send(new SendTokenPassword($token));
        return response()->json(["data"=>"Code Send To Your Email successfully"],200);
   }

   public function ChangerPassword(Request $request){
    $user=User::where("email",$request->email)->where("password_token",$request->token)->first();
    if($user){
       if($user->password_token_send_at > now()->addHour()){
         return response()->json(["data"=>"Token Expired"],404);
        }
        $user->password=bcrypt($request->password);
        $user->password_token=Null;
        $user->password_token_send_at=Null;
        $user->save();
        return response()->json(["data"=>"Password Changed With success"],200);
    }else{
        return response()->json(["data"=>"Email Or Token not found"],404);
    }
   }

}
