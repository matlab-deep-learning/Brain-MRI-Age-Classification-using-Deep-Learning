function exemplars = prepare2DImageDataset(srcFolder,dstFolder,augmentDataset,applySkullStripping)
%PREPAREMRIAGECLASSIFICATIONDATASET Prepare 2D midslice image dataset from 3D brain volume dataset
% OUTPUTS
%   exemplars: cell array of exemplar 2D midslice images (without skull-stripping or augmentation operations) as a reference, one per age class

arguments
    srcFolder (1,:) char % source folder location of 3D brain volumes, organized by participant
    dstFolder (1,:) char = '' % destination folder for 2D horizontal midslice images, organized by age class
    augmentDataset (1,1) logical = false % specify whether to apply offline data augmentation (a copy of image flipped 180 degrees). 
    applySkullStripping (1,1) logical = false % specify whether to apply skull-stripping
end

% Create classification image set folders
if ~isempty(dstFolder)
    assert(~exist(dstFolder,'dir'));
    mkdir(dstFolder);
end

% Load 3D image volumes into MATLAB workspace
allFiles = dir(strcat(srcFolder,'\*\*_anat.nii.gz'));

fileDir  = fullfile({allFiles.folder},{allFiles.name});

srcDir_3to5      = fileDir(1:65);
srcDir_7to12     = fileDir(66:122);
srcDir_Adults    = fileDir(123:155);

%Load brain volumes into MATLAB workspace
brainVolumes_3to5         = cellfun(@niftiread,srcDir_3to5,'UniformOutput',false);
brainVolumes_7to12        = cellfun(@niftiread,srcDir_7to12,'UniformOutput',false);
brainVolumes_Adults       = cellfun(@niftiread,srcDir_Adults,'UniformOutput',false);

% Load skull stripping masks into MATLAB workspace
if applySkullStripping
    allFiles = dir(strcat(srcFolder,'\*\*_analysis_mask.nii.gz'));
    fileDir  = fullfile({allFiles.folder},{allFiles.name});
    
    skullMaskDir_3to5      = fileDir(1:65);
    skullMaskDir_7to12     = fileDir(66:122);
    skullMaskDir_Adults    = fileDir(123:155);
    
    skullMask_3to5         = cellfun(@niftiread,skullMaskDir_3to5,'UniformOutput',false);
    skullMask_7to12        = cellfun(@niftiread,skullMaskDir_7to12,'UniformOutput',false);
    skullMask_Adults       = cellfun(@niftiread,skullMaskDir_Adults,'UniformOutput',false);
else
    skullMask_3to5 = [];
    skullMask_7to12 = [];
    skullMask_Adults = [];
end

% Extract, normalize, and augment 2D image sets. Return exemplar data i
%fileRoot = 'MidSlice_ImageSet\Preprocessed';
exemplars = cell(3,1);
exemplars{1} = prepare2DImageDataset_(brainVolumes_3to5,fullfile_(dstFolder,'\Ages3-5\'),augmentDataset,applySkullStripping, skullMask_3to5);
exemplars{2} = prepare2DImageDataset_(brainVolumes_7to12,fullfile_(dstFolder,'\Ages7-12\'),augmentDataset,applySkullStripping, skullMask_7to12);
exemplars{3} = prepare2DImageDataset_(brainVolumes_Adults,fullfile_(dstFolder,'\Adults\'),augmentDataset,applySkullStripping, skullMask_Adults);


end


% prepare2DImageDataset is a function that takes in the MRI image volume data for each label. It extracts the horizontal midslice of each MRI scan volume, applies normalization and other optional processing (skull stripping, augmentation), and saves the reduced 2D image dataset to a specified folder tree organized by label for downstream training, validation, and testing.
% The function's processing options can be used to:
% strip the skull from the 2D images (imType set to 'strip')
% augment the dataset by saving added copies of each 2D image flipped by 180 degrees (imModify set to true)
function exemplar = prepare2DImageDataset_(srcData,dstFolder,applyAugmentation,applySkullStripping,skullStrippingMask)

if ~isempty(dstFolder)
    assert(~exist(dstFolder,'dir'));
    mkdir(dstFolder);
end

[~, ~, k, ~] = size(srcData{1});

% Extract horizontal mid-slice from each image volume
mid_slices = cellfun(@squeeze,cellfun(@double,cellfun(@(x)x(:,:,round(k/2),1),srcData,'un',0),'UniformOutput',false),'UniformOutput',false);

% Include data from the preprocessed image that does not include the skull
% This section only runs if you wish to 'strip' away the skull
if applySkullStripping
    nii_strip_read = skullStrippingMask;
    mid_slices_unstrip = cellfun(@squeeze,cellfun(@double,cellfun(@(x)x(:,:,round(k/2),1),srcData,'un',0),'UniformOutput',false),'UniformOutput',false);
    mid_slices_strip = cellfun(@squeeze,cellfun(@double,cellfun(@(x)x(:,:,round(k/2),1),nii_strip_read,'un',0),'UniformOutput',false),'UniformOutput',false);
    mid_slices = cellfun(@immultiply,mid_slices_strip,mid_slices_unstrip,'UniformOutput',false);
end

% Normalize the intensity of the images, and save then in an RGB format
high  = cellfun(@max,(cellfun(@max,mid_slices,'UniformOutput',false)));
low   = cellfun(@min,(cellfun(@min,mid_slices,'UniformOutput',false)));
range = abs(high-low)+1;
temp  = num2cell(low);
mid_slices = cellfun(@minus,mid_slices,temp,'UniformOutput',false);

range = arrayfun(@linspace,zeros(size(range)),ones(size(range)),range,'UniformOutput',false);
map   = cellfun(@(x) repmat(x',1,3),range,'UniformOutput',false);
convert2img = cellfun(@ind2rgb, mid_slices,map,'UniformOutput',false);

avg_intensity = mean(cell2mat(cellfun(@imhist,convert2img,'UniformOutput',false)),2);

% Create a copy if the image and rorate the image by 180 degrees
if applyAugmentation
    convert2img_2 = cellfun(@ind2rgb, cellfun(@(x)rot90(x,2),mid_slices,'UniformOutput',false),map,'UniformOutput',false);
    avg_intensity_2 = mean(cell2mat(cellfun(@imhist,convert2img_2,'UniformOutput',false)),2);
end

% Save images in folders sorted by age range
for i = 1:numel(mid_slices)
    
    fileName = sprintf('image_%03d.png', i);
    outImg = histeq(convert2img{i},avg_intensity);    
    
    if ~isempty(dstFolder)
        imwrite(outImg,strcat(dstFolder,fileName),'mode','lossless');
    end
    
    if i == 1
        exemplar = outImg;
    end
    
    if applyAugmentation
        fileName_2 = sprintf('image2_%03d.png', i);
        outImg_2 = histeq(convert2img_2{i},avg_intensity_2);
        
        if ~isempty(dstFolder)
            imwrite(outImg_2, strcat(dstFolder,fileName_2),'mode','lossless');
        end
    end
end

end

function fname = fullfile_(dstFolder,varargin)
if isempty(dstFolder)
    fname = [];
else
    fname = fullfile(dstFolder,varargin{:});
end
end