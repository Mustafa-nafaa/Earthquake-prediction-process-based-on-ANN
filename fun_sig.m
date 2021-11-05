function   check =  fun_sig(t, y,thr)
mu= mean(t);
sig = std(t);
% y = y .* sig+mu;
% t = t .* sig+mu;
diff=abs(t-y);
diff=diff/thr;
sig
check = (diff < sig );