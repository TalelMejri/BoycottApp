@component('mail::message')
 <p style="text-align: center">Your Token</p>
 @component('mail::panel')
 <p style="font-size: 30px;text-align: center">
    {{$token}}
 </p>
 @endcomponent
@endcomponent
