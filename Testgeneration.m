clear all
clc

old_path =pwd
cd dataset
filesStruct = dir
files = {filesStruct.name};
 cd(old_path); ii=1
 Features=[]; classLabel=[];
for kk = numel(files)/2:numel(files)
   
    cd dataset
    inimage=files{kk};
    load(inimage(1:29));
    cd(old_path);
    %dispimage(imageData.originalImage, imageData.roiMask);     %just to check the results
    
    %extract Training file
    classLabel = imageData.roiMask(:);           %Label class extraction
    
    RedVect= imageData.originalImage(:,:,1);        %RGB features Extraction 
    Red=RedVect(:);
    GreenVect=imageData.originalImage(:,:,2);
    Green=GreenVect(:);
    BlueVect=imageData.originalImage(:,:,3);
    Blue=BlueVect(:);

    originalImVect = [ classLabel, Red,Green,Blue];
    Features=[Features;originalImVect];
    %save test file 
    FeatSorted=sortrows(Features);
    s1=find(FeatSorted(:,1)==1);
    s2=find(FeatSorted(:,1)==2);
    s3=find(FeatSorted(:,1)==3);
    s4=find(FeatSorted(:,1)==4);
    class1=FeatSorted(min(s1):max(s1),:);
    class2=FeatSorted(min(s2):max(s2),:);
    class3=FeatSorted(min(s3):max(s3),:);
    class4=FeatSorted(min(s4):max(s4),:);
    clear FeatSorted, Features;

    %save  the data into a Test file data
    test=[];
    test=[test;class1;class2;class3;class4];

    clear class1;clear class2; clear class3;
    clear class4;  clear s1;
    clear s2;clear s3; clear s4;
    %normalize the train data between 0 and 1
    labtest=test(:,1);
    feattest=double(test(:,2:4));
    maxval=double(max(max(test(:,2:4))));
    feattest2=feattest./maxval;
    
    testname=['test', num2str(ii),'.libsvm'];
    ii=ii+1
    mat2libsvm(feattest2,labtest, testname);
    
    clear feattest; clear labeltest; clear maxval; clear feattest2;
    Features=[]; classLabel=[];
end
 
%write in libsvm file format 
