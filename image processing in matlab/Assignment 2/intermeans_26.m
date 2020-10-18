function thres = intermeans_26(im)
%intermeans_26 function implements the intermeans algorithm. The intermeans algorithm
%is used to automatically find a threshold to binarize an image.
%
%function thres = intermeans_26(im); where input im is a uint8 intensity image,
%and output thres is the scalar normalized threshold that is between 0.0 to 1.0.

    [h, D] = imhist(im); %Where for a uint8 image im: D(1)=0 and D(end)=255
    h = h.'; %Transpose of vector h
    thres = round(mean2(im)); %Initial threshold value
    thres_prev = thres + 1;
    
    while thres_prev ~= thres
        thres_prev = thres;
        
        DLow = D(1):1:thres_prev; %Computing gray-levels for μ1
        meanLow = sum(DLow .* h(1:1:length(DLow))) / sum(h(1:1:length(DLow))); %Computing μ1
        
        DHi = thres_prev+1:1:D(end); %Computing gray-levels for μ2
        meanHi = sum(DHi .* h(length(DLow)+1:1:D(end)+1)) / sum(h(length(DLow)+1:1:D(end)+1)); %Computing μ2
        
        thres = round((meanLow + meanHi) / 2); %Updating threshold value
    end
    
    thres = (thres - D(1)) / (D(end) - D(1)); %Normalizing threshold value: N_x=(x−min)/(max−min)

end