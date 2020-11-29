% 得到序列粗略周期
% function Tx = getzq(x)
    x=repmat([1:11],1,60);x=horzcat(x,[1:5]);
    fw=abs(fft(x));
    %     plot(fw,'.')
    lenx = length(x);
    [~,idx]=sort(fw(2:floor(length(fw)/2)),'descend');
    zqs=idx(1);
    tmax = min(ceil(lenx/(zqs-1)),lenx);
    tmin = max(floor(lenx/(zqs+1)),2);
    tnum = tmax-tmin+1;
    var_when_t = zeros(tnum,1);
    for t = tmin:tmax
        n_when_t = floor(lenx/t);
        newx = reshape(x(1:n_when_t*t),t,n_when_t);
        var_when_t(t-tmin+1) = mean(var(newx,0,2));
    end
    [~,idxy] = sort(var_when_t);
    Tx=(idxy(1)+tmin-1);
% end