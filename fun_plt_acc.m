function    fun_plt_acc(check,str)
cls=  sum(check');
figure; 
cls=  sum(check');
subplot(211); plot(cls); title('Test Score')
xlabel('Sample Number'); ylabel('Score'); 
subplot(223); histogram(cls); 
title('Histogram of Test Score')
ylabel('Number of Samples')
xlabel('Score'); grid on;
xticklabels(str)


accury =  [];
for  i=1:size(check,2)
 accury =  [accury , sum(check(:,i))/ length(check(:,i))]
end
subplot(224); bar(accury); 
title('Test Accuracy')

ylabel('Accuracy (%)')
xlabel('Score'); grid on;
xticklabels(str)
