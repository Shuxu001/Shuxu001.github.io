function y=mean3(x)
    y = sum(sum(sum(x)))/numel(x);
end