% run this program for Video to Frame Conversion....
%Change the input video file name in the program with the same file name.
clc;
clear all;
close all;
warning off;
tic;
vid=VideoReader('traffic.avi');
 numFrames = vid.NumberOfFrames;
 n=numFrames;
 for frm = 1:102
 frames = read(vid,frm);
 imwrite(frames,['Image', int2str(frm), '.jpg']);
 im(frm)=image(frames);

 clf;
 if frm == 1
 ref=imread('Image1.jpg');

 else
      ip=imread(strcat('Image', int2str(frm), '.jpg'));
      figure(1),subplot(1,3,1),imshow(ip),title(strcat('Image', int2str(frm)));
     
      
      dif = ip-ref;
       imwrite(dif,['Diff Image', int2str(frm), '.jpg']);
 
  
 for x =1: size(dif,1)
     for y =  1: size(dif,2)
         if dif(x,y) >= 40
             dif1(x,y) = 1;
             dif2(x,y) = 0;
         else
             dif1(x,y) = 0;
             dif2(x,y) = ref(x,y);
         end
         
     end
 end 
se= strel('disk',4);
 dif1=imclose(dif1,se);
subplot(1,3,2),imshow(dif2),title('Difference with ref background');
 imwrite(dif1,['Diff Image new', int2str(frm), '.jpg']);
 difb=im2bw(imread(strcat('Diff Image new', int2str(frm), '.jpg')));    

 st = regionprops(difb, 'BoundingBox', 'Area' );
    for ii= 1 : length(st)
        Areai(ii)= st(ii).Area;
    end
    largest_blob_id1= find(Areai==max(Areai));
    if largest_blob_id1 > 4 

    largest_blob_id1 = 4;
    subplot(1,3,3),imshow(difb),title('Object detected in present frame'); 
    rectangle('Position',[st(largest_blob_id1).BoundingBox(1),st(largest_blob_id1).BoundingBox(2),st(largest_blob_id1).BoundingBox(3),st(largest_blob_id1).BoundingBox(4)], 'EdgeColor','r','LineWidth',2 )

    else

         subplot(1,3,3),imshow(difb),title('Object detected in present frame'); 
         rectangle('Position',[st(largest_blob_id1).BoundingBox(1),st(largest_blob_id1).BoundingBox(2),st(largest_blob_id1).BoundingBox(3),st(largest_blob_id1).BoundingBox(4)], 'EdgeColor','r','LineWidth',2 )

    end
pause(4)

 end
 end
 toc;



