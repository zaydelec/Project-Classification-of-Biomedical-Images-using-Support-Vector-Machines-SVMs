%**********************************************
% compute the cross validation of the genetic 
% learning set and classify the test set 
%**********************************************
%

%function Acc_cv = cross_valid();
% 	ptr_res=fopen('modelsel_cv.pat','w');
% 	fprintf(ptr_res, 'Model selection ');
% 	fprintf(ptr_res, '=========================');
% 	
% 	ptr_acc=fopen('test_acc.pat','w');
% 	fprintf(ptr_res,'\n Test classification \n');
% 	
% 	fprintf(ptr_res,'C \t classe 1 \t classe 2 \t OA \n');
% 	fprintf(ptr_acc,'Class 1 \t Class 2 \t OA \n');
% 
	i=1;
	for c=25:25:200
        str=['svm-train -c ', num2str(c),  ' -g 0.01 -v 5 ', 'train.libsvm']
        [s,w] = system(str);
        % save results 
        M_modsel(i,1)=c; 
        k = strfind(w, 'Cross Validation Accuracy = '); taille=length('Cross Validation Accuracy = '); 
        nbnumber=length(w)-(k+taille);str= w(k+taille:k+taille+nbnumber);  Acc=sscanf(str,'%f');
        M_modsel(i,2)=Acc; 
        i=i+1;
	end
	[BestOA,indxc]=max(M_modsel(:,2));	BestC=M_modsel(indxc,1);
	ligamma=i;
	
	% the best gamma
    i=1;
	for gamma=0.25:0.25:2
        str=['svm-train -c ', num2str(BestC), ' -g ', num2str(gamma), ' -v 5 train.libsvm']
        [s,w] = system(str);
        % save results 
        M_modsel(i,1)=gamma; 
	
        k = strfind(w, 'Cross Validation Accuracy = ');  taille=length('Cross Validation Accuracy = '); 
        nbnumber=length(w)-(k+taille);str= w(k+taille:k+taille+nbnumber);  Acc=sscanf(str,'%f');
        M_modsel(i,2)=Acc; 
        i=i+1;
	end
	[Bestgamma,indxg]=max(M_modsel(ligamma:i-1,2));
	Bestg=M_modsel(indxg+ligamma-1,1);
	
	%save results in file 
	
% 	[lig, col]=size(M_modsel);
% 	for i = 1:lig
%         for j = 1:col
%             fprintf(ptr_res, '%f\t', M_modsel(i,j));
%         end
%         fprintf(ptr_res, '\n');
% 	end
% 	fprintf(ptr_res, 'Best C= %f \n', BestC);
% 	fprintf(ptr_res, 'Best Gamma=%f\n', Bestg);
% 	fprintf(ptr_res, 'Best OA Crossvalidation =%f\n', Bestgamma);
% 	
	str=['svm-train -c ', num2str(BestC), ' -g ', num2str(Bestg), '  train.libsvm','  model_cv']
	system(str);
	
    
% % % % 	str=['svm-predict ',  ' test.libsvm ',' model_cv est_label.pat'];
% % % % 	[s,w] =  system(str);
% % % % 	
% % % % 	k = strfind(w, 'class 1:  OA='); taille=length('class 1:  OA='); str= w(k+taille:k+taille+5);  Acc1=sscanf(str,'%f');
% % % % 	k = strfind(w, 'class 2:  OA='); taille=length('class 2:  OA='); str= w(k+taille:k+taille+5);  Acc2=sscanf(str,'%f');
% % % % 	k = strfind(w, 'Average Accuracy='); taille=length('Average Accuracy='); str= w(k+taille:k+taille+5);  OA=sscanf(str,'%f');
% % % % 	
% % % % 	Acc_cv =[BestC Bestg Bestgamma Acc1 Acc2 OA];

    
    
    
    % 
% fprintf(ptr_acc,' %f\t %f\t %f\n',  Acc1, Acc2, OA );
% fclose(ptr_res);
% fclose(ptr_acc);




%*****************************
%Train on the global training 
% Test on the local tests 
%*****************************
% clear all
% clc
% ptr=fopen('Upper_ACC_20rec.pat','w');
% fprintf(ptr,'\n Taining = 20 records \n');
% fprintf(ptr,'\n Local Test classification \n');
% fprintf(ptr,'Record # \t Class 1 \t Class 2 \t OA \n');
% 
% old_path =pwd
% filesStruct = dir('Record*.');
% fold = {filesStruct.name};
% 
% for kk = 1:numel(fold)
%     fold{kk}
%     cd(fold{kk});
%     Num= fold{kk}(8:10)
% 
%     %system('copy model_cv400');
%     filename= [old_path,'\model_cv20rec'];     
%     copyfile(filename);
%    
%     str=['svm-predict ',  'test.pat ',' model_cv20rec est_label_20rec.pat'];
%     [s,w] =  system(str);
% 
%     k = strfind(w, 'class 1:  OA='); taille=length('class 1:  OA='); str= w(k+taille:k+taille+5);  Acc1=sscanf(str,'%f');
%     k = strfind(w, 'class 2:  OA='); taille=length('class 2:  OA='); str= w(k+taille:k+taille+5);  Acc2=sscanf(str,'%f');
%     k = strfind(w, 'Average Accuracy='); taille=length('Average Accuracy='); str= w(k+taille:k+taille+5);  OA=sscanf(str,'%f');
%     fprintf(ptr,' %d\t %f\t %f\t %f\n',  str2num(Num), Acc1, Acc2, OA );
%     
%     cd(old_path);
%end
%fclose(ptr);

    
 