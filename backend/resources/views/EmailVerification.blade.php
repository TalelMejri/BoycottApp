@component('mail::message')
<p style="color:#000;font-weight:600">
    Hi {{$user->LastName}}<br>
    We're happy you signed up for Boycott.To start<br>
    exploring the App.<br>
    please confirm your emails address.
</p>
 @component('mail::panel')
 <p style="text-align:center">Token Verification</p>
      <br>
    <button style="text-align: center" style="color: green">{{$user->email_token}}</button>
 @endcomponent
 <p style="text-align:center"> Matrix Masters Team</p>
@endcomponent
