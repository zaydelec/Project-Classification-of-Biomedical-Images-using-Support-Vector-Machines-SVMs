clear all
clc

old_path =pwd
cd dataset
filesStruct = dir
files = {filesStruct.name};
 cd(old_path);
 Features=[]; classLabel=[];
for kk = 3:numel(files)/2
    
%for kk = 3:5
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
    Features = [Features;originalImVect];
   
end
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
%sample the data into a new training file data
nbsamples=3000;                                  %free parameter
indexc1=ceil(max(s1) * rand(1,nbsamples) );
indexc2=ceil((max(s2)-min(s2)) * rand(1,nbsamples) );
indexc3=ceil((max(s3)-min(s3)) * rand(1,nbsamples) );
indexc4=ceil((max(s4)-min(s4)) * rand(1,nbsamples) );

train=[]
for i=1:nbsamples
    train=[train;class1(indexc1(i),:);class2(indexc2(i),:);class3(indexc3(i),:);class4(indexc4(i),:)]; 
end
%normalize the train data between 0 and 1
labtrain=train(:,1);
feattrain=double(train(:,2:4));
maxval=double(max(max(train(:,2:4))));
feattrain2=feattrain./maxval;
mat2libsvm(feattrain2,labtrain, 'train.libsvm')             %write in libsvm file format 
clc
%SVM Parameter estimation using cross-validation 5 folds
cross_valid();



