function   [strr timm ]  = calcute_time(dd,tt,output)

dd=num2str(dd);
ay=str2num(dd(1:4));
am=str2num(dd(5:6));
ad=str2num(dd(7:8));

tt=num2str(tt);
tt=(tt(1: end-2));
mint= str2num(tt(end-1:end));
if   size(tt,1)>3
    hour=  str2num(tt(1,2));
else
    hour=  str2num(tt(1));
end



while (output>0)
   while (am<13) &&  (output>0)
    while (ad<31) &&  (output>0)
    while (hour<24) &&  (output>0)
    while (mint<60) &&  (output>0)
        mint =mint+1;
        output=output-1;
    end
    if (mint>=60)
            mint=0;
            hour=hour+1;
    end
    end
    if (hour>=24)
            hour=0;
            ad=ad+1;
    end
   end
     if (ad>30)
            ad=1;
            am=am+1;
    end
   end
   
    if (am>12)
            am=1;
            ay=ay+1;
    end
end
   
strr =  [ num2str(ay) '/'  num2str(am) '/' num2str(ad)];
timm =[ num2str(hour) ':'  num2str(mint) ];

