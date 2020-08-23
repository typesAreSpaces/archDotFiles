#!/bin/bash
float=$(light -G)
value=${float%.*}
font="%{T6}"

unablecolor="%{F#555}"
if [ $value -gt 90 ]
then
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳﭳﭳﭳﭳﭳﭳﭳﭳﭳ%{F-}%{T-}"
elif [ $value -gt 80 ]
then
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳﭳﭳﭳﭳﭳﭳﭳﭳ$unablecolorﭳ%{F-}%{T-}"
elif [ $value -gt 70 ]
then
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳﭳﭳﭳﭳﭳﭳﭳ$unablecolorﭳﭳ%{F-}%{T-}"
elif [ $value -gt 60 ]
then
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳﭳﭳﭳﭳﭳﭳ$unablecolorﭳﭳﭳ%{F-}%{T-}"
elif [ $value -gt 50 ]
then
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳﭳﭳﭳﭳﭳ$unablecolorﭳﭳﭳﭳ%{F-}%{T-}"
elif [ $value -gt 40 ]
then
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳﭳﭳﭳﭳ$unablecolorﭳﭳﭳﭳﭳ%{F-}%{T-}"
elif [ $value -gt 30 ]
then
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳﭳﭳﭳ$unablecolorﭳﭳﭳﭳﭳﭳ%{F-}%{T-}"
elif [ $value -gt 20 ]
then
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳﭳﭳ$unablecolorﭳﭳﭳﭳﭳﭳﭳ%{F-}%{T-}"
elif [ $value -gt 10 ]
then
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳﭳ$unablecolorﭳﭳﭳﭳﭳﭳﭳﭳ%{F-}%{T-}"
#elif [ $value -gt 0 ]
#then
else
echo -e "$fontﯦ%{T-}  $font%{F#F0CC00}ﭳ$unablecolorﭳﭳﭳﭳﭳﭳﭳﭳﭳ%{F-}%{T-}"
fi
