% clear all
% clc
c=175
g=1
% str=['svm-train -c 175 -g 1 ',  'train.libsvm','  model']
% system(str);

ptr=fopen('test_acc.pat','w');
fprintf(ptr,'\n Test classification \n');
 	
fprintf(ptr,' classe 1 \t classe 2 \t classe 3 \t classe 3 \t OA \n');
fprintf(ptr,'Class 1 \t Class 2 \t  Class 3 \t  Class 4 \t OA \n');

for i =7:14 
    testfile=['test',num2str(i),'.libsvm']
    str=['svm-predict ',  testfile,' model est_label.pat'];
    [s,w] =  system(str);
    k = strfind(w, 'class 1:  OA='); taille=length('class 1:  OA='); str= w(k+taille:k+taille+5);  Acc1=sscanf(str,'%f');
    k = strfind(w, 'class 2:  OA='); taille=length('class 2:  OA='); str= w(k+taille:k+taille+5);  Acc2=sscanf(str,'%f');
    k = strfind(w, 'class 3:  OA='); taille=length('class 3:  OA='); str= w(k+taille:k+taille+5);  Acc3=sscanf(str,'%f');
    k = strfind(w, 'class 4:  OA='); taille=length('class 4:  OA='); str= w(k+taille:k+taille+5);  Acc4=sscanf(str,'%f');
    k = strfind(w, 'Average Accuracy='); taille=length('Average Accuracy='); str= w(k+taille:k+taille+5);  OA=sscanf(str,'%f');
    fprintf(ptr,' %f\t  %f\t  %f\t %f\t %f\n',  Acc1, Acc2, Acc3,Acc4, OA );
end
 
fclose(ptr);