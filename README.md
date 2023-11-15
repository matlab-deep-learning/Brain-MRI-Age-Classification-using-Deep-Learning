[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=matlab-deep-learning/Brain-MRI-Age-Classification-using-Deep-Learning&file=BrainMRIAgeClassificationUsingDeepLearning.mlx) [![View Brain-MRI-Age-Classification-using-Deep-Learning on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/74941-brain-mri-age-classification-using-deep-learning)

# **Brain MRI Age Classification Using Deep Learning**

This example shows how to work with an MRI brain image dataset and how to use transfer learning to modify and retrain ResNet-18, a pretrained convolutional neural network, to perform image classification on that dataset.

👀 [View the example](https://viewer.mathworks.com/?viewer=live_code&url=https%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Fmlc-downloads%2Fdownloads%2Fcb382fe4-455d-46c6-a137-a396f1cfffd7%2F9f0a19d9-cbba-4729-ad85-29a073fa2b54%2Ffiles%2FBrainMRIAgeClassificationUsingDeepLearning.mlx&embed=web) ▶️ [Run the example](https://matlab.mathworks.com/open/github/v1?repo=matlab-deep-learning/Brain-MRI-Age-Classification-using-Deep-Learning&file=BrainMRIAgeClassificationUsingDeepLearning.mlx)

### About the Data
The MRI scans used in this example were obtained during a study \[1\] of social brain development conducted by researchers at the Massachussets Institute of Technology (MIT), and are available for download via the OpenNEURO platform:
    https://openneuro.org/datasets/ds000228/versions/1.1.0

### About the Workflow 
This example uses the horizontal midslice images from the brain MRI scan volumes and classifies them into 3 categories according to the chronological age of the participant:
1. Participants Aged 3-5
2. Participants Aged 7-12
3. Participants older than 18, classified as Adults

![](images/overview.png)
This example works though multiple steps of a deep learning workflow:
- _Exploring_ a public brain MRI image dataset
- _Preparing_ the dataset for deep learning
- _Training_ a deep learning model to perform chronological age classification
- _Evaluating_ the trained model

### **Running the Example**
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=matlab-deep-learning/Brain-MRI-Age-Classification-using-Deep-Learning&file=BrainMRIAgeClassificationUsingDeepLearning.mlx) to run the example in your web browser with no installation required. 

To run on local machine or cloud instance, open and run the live script `BrainMRIAgeClassificationUsingDeepLearning.mlx`. 

Requires:
- [MATLAB](https://www.mathworks.com/products/matlab.html) (version R2019b or later)
- [Deep Learning Toolbox](https://www.mathworks.com/products/deep-learning.html)
- [Image Processing Toolbox](https://www.mathworks.com/products/image.html)

## **References**
\[1\] Richardson, H., Lisandrelli, G., Riobueno-Naylor, A., & Saxe, R. (2018). Development of the social brain from age three to twelve years. Nature Communications, 9(1), 1027. https://doi.org/10.1038/s41467-018-03399-2

Copyright 2020 The MathWorks, Inc.
